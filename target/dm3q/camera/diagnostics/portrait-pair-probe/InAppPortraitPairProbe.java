// SPDX-License-Identifier: Apache-2.0
package com.rezoss.camera.diagnostics;

import android.app.Activity;
import android.app.Application;
import android.content.Intent;
import android.graphics.ImageFormat;
import android.hardware.camera2.*;
import android.hardware.camera2.params.OutputConfiguration;
import android.hardware.camera2.params.SessionConfiguration;
import android.hardware.camera2.params.StreamConfigurationMap;
import android.media.Image;
import android.media.ImageReader;
import android.os.Bundle;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Looper;
import android.util.Log;
import android.util.Range;
import android.util.Size;
import android.widget.Toast;
import org.json.JSONArray;
import org.json.JSONObject;
import java.io.File;
import java.io.FileOutputStream;
import java.nio.charset.StandardCharsets;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.security.MessageDigest;
import java.util.*;

/** Opt-in probe in Samsung Camera's own process. Pixel samples require a second opt-in. */
public final class InAppPortraitPairProbe implements Application.ActivityLifecycleCallbacks {
    public static final String EXTRA = "com.rezoss.camera.extra.RUN_PORTRAIT_PAIR_PROBE";
    private static final String TAG = "PortraitPairInApp", LOGICAL = "20";
    private final String MAIN, AUX;
    private final float nominalMainZoom;
    private static final Handler UI = new Handler(Looper.getMainLooper());
    private static InAppPortraitPairProbe active;
    private final Activity owner;
    private final HandlerThread worker = new HandlerThread("portrait-pair-inapp");
    private final Map<String, Set<Long>> images = new LinkedHashMap<>();
    private final Set<Long> pairedResults = new HashSet<>();
    private final List<ImageReader> readers = new ArrayList<>();
    private final String runId = Long.toString(System.currentTimeMillis());
    private final File report;
    private Handler handler;
    private CameraDevice camera;
    private CameraCaptureSession session;
    private boolean stopped;
    // Installed armer checks this version before requesting new behavior.
    private static final String VERSION = "portrait-controls-v3-yuv-v4f";
    private final boolean geometry, saveFrames, controlled, saveYuv;
    private final Map<String, CameraCharacteristics> physicalCharacteristics = new HashMap<>();
    private final Map<String, Set<Long>> selectedSampleTicks = new HashMap<>();
    private final Map<String, Long> lastSampleAt = new HashMap<>();
    private Set<CaptureRequest.Key<?>> physicalKeys;
    private CameraCharacteristics logicalCharacteristics;
    private Range<Integer> commonFps;
    private final Map<String, Float> focusedDistances = new HashMap<>();
    private long exposureNs, frameNs;
    private int lowIso, highIso;
    private boolean manualSupported;
    private String arrivalPhase = "zoom10";
    private long phaseStarted;
    private final Map<String, Integer> saved = new HashMap<>();
    private int results;
    private long settledPairAt;
    private final LinkedHashMap<Long, Map<String, YuvSample>> pendingYuv = new LinkedHashMap<>();
    private final LinkedHashMap<Long, String> yuvResultPhases = new LinkedHashMap<>();
    private final Set<Long> settledYuvResults = new HashSet<>();
    private final Map<String, Integer> savedYuvPairs = new HashMap<>();
    private final Map<String, Long> lastYuvSampleNs = new HashMap<>();
    private final Runnable timeout = () -> stop("timeout");

    private InAppPortraitPairProbe(Activity activity, String options) {
        owner = activity;
        boolean firstTele = options.equals("controlled-yuv-3x");
        MAIN = firstTele ? "52" : "54";
        AUX = firstTele ? "56" : "52";
        nominalMainZoom = firstTele ? 3f : 10f;
        saveYuv = firstTele || options.equals("controlled-yuv");
        controlled = saveYuv || options.equals("controlled") || options.equals("controlled-frames");
        geometry = controlled || options.equals("geometry") || options.equals("geometry-frames");
        saveFrames = saveYuv || options.equals("geometry-frames") || options.equals("controlled-frames");
        report = new File(activity.getFilesDir(), "portrait-pair-probe/report.jsonl");
    }

    /** Called from CameraSettingActivity.onResume; unarmed launches do not open a camera. */
    public static void maybeStart(Activity activity) {
        try {
            Intent intent = activity.getIntent();
            File arm = new File(activity.getCacheDir(), "portrait-pair-probe.arm");
            boolean requested = intent != null && intent.getBooleanExtra(EXTRA, false);
            if (!requested && !arm.isFile()) return;
            if (intent != null) intent.removeExtra(EXTRA);
            String options = arm.isFile() ? new String(Files.readAllBytes(arm.toPath()), StandardCharsets.UTF_8).trim() : "";
            if (!options.isEmpty() && !options.equals("geometry") && !options.equals("geometry-frames") && !options.equals("controlled") && !options.equals("controlled-frames") && !options.equals("controlled-yuv") && !options.equals("controlled-yuv-3x")) {
                Log.e(TAG, "Unknown diagnostic profile; refusing to run"); return;
            }
            // The marker is app-private; root can create it before a normal Settings launch.
            if (arm.isFile() && !arm.delete()) {
                Log.e(TAG, "Cannot consume diagnostic marker"); return;
            }
            if (!"com.sec.android.app.camera".equals(activity.getPackageName()) ||
                    android.os.Process.myUid() != activity.getApplicationInfo().uid) return;
            synchronized (InAppPortraitPairProbe.class) {
                if (active != null) return;
                active = new InAppPortraitPairProbe(activity, options);
                InAppPortraitPairProbe probe = active;
                activity.getApplication().registerActivityLifecycleCallbacks(probe);
                probe.worker.start();
                probe.handler = new Handler(probe.worker.getLooper());
                UI.postDelayed(() -> {
                    if (activity.isFinishing() || activity.isDestroyed() || !activity.hasWindowFocus()) {
                        probe.handler.post(() -> probe.stop("owner_not_foreground"));
                        return;
                    }
                    Toast.makeText(activity, probe.controlled ? "Portrait controls diagnostic: 32 seconds" : "Portrait pair diagnostic: 15 seconds", Toast.LENGTH_SHORT).show();
                    probe.handler.post(probe::begin);
                }, 800);
            }
        } catch (Exception error) {
            Log.e(TAG, "Cannot start opt-in diagnostic", error);
        }
    }

    private void emit(String event, Object... fields) {
        try {
            JSONObject row = new JSONObject().put("event", event).put("run_id", runId);
            for (int i = 0; i < fields.length; i += 2) row.put(fields[i].toString(), fields[i+1]);
            Log.i(TAG, row.toString());
            File parent = report.getParentFile();
            if (!parent.isDirectory() && !parent.mkdirs()) throw new IllegalStateException("Cannot create report directory");
            try (FileOutputStream output = new FileOutputStream(report, true)) {
                output.write((row + "\n").getBytes(StandardCharsets.UTF_8));
            }
        } catch (Exception error) { Log.e(TAG, "Cannot write diagnostic report", error); }
    }
    private void fail(String stage, Exception error) {
        emit("error", "stage", stage, "type", error.getClass().getName(), "message", String.valueOf(error.getMessage()));
        stop(stage);
    }
    private static String hash(byte[] bytes) throws Exception {
        StringBuilder s = new StringBuilder();
        for (byte b : MessageDigest.getInstance("SHA-256").digest(bytes)) s.append(String.format(Locale.ROOT, "%02x", b & 255));
        return s.toString();
    }
    private void inventory(CameraManager manager, String id) throws Exception {
        CameraCharacteristics c = manager.getCameraCharacteristics(id);
        emit("camera", "id", id, "physical_ids", new JSONArray(c.getPhysicalCameraIds()),
            "focal_lengths", Arrays.toString(c.get(CameraCharacteristics.LENS_INFO_AVAILABLE_FOCAL_LENGTHS)),
            "active_array", String.valueOf(c.get(CameraCharacteristics.SENSOR_INFO_ACTIVE_ARRAY_SIZE)),
            "pre_correction_active_array", String.valueOf(c.get(CameraCharacteristics.SENSOR_INFO_PRE_CORRECTION_ACTIVE_ARRAY_SIZE)),
            "pixel_array_size", String.valueOf(c.get(CameraCharacteristics.SENSOR_INFO_PIXEL_ARRAY_SIZE)),
            "cropping_type", String.valueOf(c.get(CameraCharacteristics.SCALER_CROPPING_TYPE)),
            "sync_type", String.valueOf(c.get(CameraCharacteristics.LOGICAL_MULTI_CAMERA_SENSOR_SYNC_TYPE)),
            "timestamp_source", String.valueOf(c.get(CameraCharacteristics.SENSOR_INFO_TIMESTAMP_SOURCE)),
            "intrinsics", Arrays.toString(c.get(CameraCharacteristics.LENS_INTRINSIC_CALIBRATION)),
            "distortion", Arrays.toString(c.get(CameraCharacteristics.LENS_DISTORTION)),
            "distortion_correction_modes", Arrays.toString(c.get(CameraCharacteristics.DISTORTION_CORRECTION_AVAILABLE_MODES)),
            "rotate_and_crop_modes", Arrays.toString(c.get(CameraCharacteristics.SCALER_AVAILABLE_ROTATE_AND_CROP_MODES)),
            "ois_modes", Arrays.toString(c.get(CameraCharacteristics.LENS_INFO_AVAILABLE_OPTICAL_STABILIZATION)),
            "video_stabilization_modes", Arrays.toString(c.get(CameraCharacteristics.CONTROL_AVAILABLE_VIDEO_STABILIZATION_MODES)),
            "pose_rotation", Arrays.toString(c.get(CameraCharacteristics.LENS_POSE_ROTATION)),
            "pose_translation", Arrays.toString(c.get(CameraCharacteristics.LENS_POSE_TRANSLATION)),
            "physical_request_keys", String.valueOf(c.getAvailablePhysicalCameraRequestKeys()),
            "af_modes", Arrays.toString(c.get(CameraCharacteristics.CONTROL_AF_AVAILABLE_MODES)),
            "min_focus_diopters", String.valueOf(c.get(CameraCharacteristics.LENS_INFO_MINIMUM_FOCUS_DISTANCE)),
            "focus_calibration", String.valueOf(c.get(CameraCharacteristics.LENS_INFO_FOCUS_DISTANCE_CALIBRATION)),
            "orientation", String.valueOf(c.get(CameraCharacteristics.SENSOR_ORIENTATION)),
            "fps_ranges", Arrays.toString(c.get(CameraCharacteristics.CONTROL_AE_AVAILABLE_TARGET_FPS_RANGES)),
            "exposure_range", String.valueOf(c.get(CameraCharacteristics.SENSOR_INFO_EXPOSURE_TIME_RANGE)),
            "sensitivity_range", String.valueOf(c.get(CameraCharacteristics.SENSOR_INFO_SENSITIVITY_RANGE)),
            "capabilities", Arrays.toString(c.get(CameraCharacteristics.REQUEST_AVAILABLE_CAPABILITIES)));
        for (String name : new String[]{"samsung.android.logicalMultiCamera.dualCalibration",
                "samsung.android.logicalMultiCamera.dualCalibrationT_W", "samsung.android.logicalMultiCamera.dualCalibrationT2_T1"}) {
            try {
                byte[] data = c.get(new CameraCharacteristics.Key<byte[]>(name, byte[].class));
                if (data == null) emit("calibration_blob", "id", id, "key", name, "present", false);
                else emit("calibration_blob", "id", id, "key", name, "present", true, "bytes", data.length, "sha256", hash(data));
            } catch (IllegalArgumentException missing) {
                emit("calibration_blob", "id", id, "key", name, "present", false, "error", String.valueOf(missing.getMessage()));
            }
        }
    }
    private void begin() {
        if (stopped) return;
        emit("begin", "route", "camera_settings_in_process", "logical", LOGICAL, "main", MAIN, "aux", AUX,
            "uid", android.os.Process.myUid(), "pid", android.os.Process.myPid(),
            "version", VERSION, "geometry", geometry, "controlled", controlled, "save_frames", saveFrames, "save_yuv", saveYuv,
            "nominal_main_zoom", nominalMainZoom, "framing_applied_in_camera", false, "pair_transition_enabled", false);
        handler.postDelayed(timeout, controlled ? 32000 : 15000);
        try {
            CameraManager manager = owner.getApplication().getSystemService(CameraManager.class);
            for (String id : new String[]{LOGICAL, MAIN, AUX}) inventory(manager, id);
            CameraCharacteristics logical = manager.getCameraCharacteristics(LOGICAL);
            logicalCharacteristics = logical;
            if (!logical.getPhysicalCameraIds().containsAll(Arrays.asList(MAIN, AUX)))
                throw new IllegalStateException("Requested physical pair absent from logical camera");
            if (controlled) prepareControls(manager, logical);
            Range<Float> zoom = logical.get(CameraCharacteristics.CONTROL_ZOOM_RATIO_RANGE);
            if (zoom == null || (controlled ? !zoom.contains(1f) : !zoom.contains(10f) || (geometry && !zoom.contains(1f))))
                throw new IllegalStateException("Required logical request zoom not advertised");
            StreamConfigurationMap a = manager.getCameraCharacteristics(MAIN).get(CameraCharacteristics.SCALER_STREAM_CONFIGURATION_MAP);
            StreamConfigurationMap b = manager.getCameraCharacteristics(AUX).get(CameraCharacteristics.SCALER_STREAM_CONFIGURATION_MAP);
            if (a == null || b == null) throw new IllegalStateException("Missing physical stream map");
            Size[] sa = a.getOutputSizes(ImageFormat.YUV_420_888), sb = b.getOutputSizes(ImageFormat.YUV_420_888);
            if (sa == null || sb == null) throw new IllegalStateException("Missing physical YUV outputs");
            Set<Size> other = new HashSet<>(Arrays.asList(sb));
            List<Size> common = new ArrayList<>();
            for (Size s : sa) if (other.contains(s) && s.getWidth() >= 640 && s.getHeight() >= 480 &&
                    s.getWidth() <= 1920 && s.getHeight() <= 1080) common.add(s);
            common.sort(Comparator.comparingLong(s -> (long)s.getWidth()*s.getHeight()));
            if (common.isEmpty()) throw new IllegalStateException("No common bounded YUV size");
            Size size = common.get(0);
            if (saveYuv && !size.equals(new Size(640, 480))) throw new IllegalStateException("Native-map profile requires advertised640x480 on both lenses");
            emit("chosen_size", "size", size.toString());
            List<OutputConfiguration> outputs = new ArrayList<>();
            for (String id : new String[]{MAIN, AUX}) {
                images.put(id, new HashSet<>());
                ImageReader reader = ImageReader.newInstance(size.getWidth(), size.getHeight(), ImageFormat.YUV_420_888, 3);
                reader.setOnImageAvailableListener(r -> {
                    try (Image image = r.acquireNextImage()) {
                        if (image != null && !stopped) {
                            Set<Long> timestamps = images.get(id);
                            if (timestamps.size() < 900) timestamps.add(image.getTimestamp());
                            if (geometry || timestamps.size() <= 5) emit("image", "physical_output", id,
                                "timestamp_ns", image.getTimestamp(), "arrival_phase", arrivalPhase,
                                "luma", lumaStats(image), "arrival_elapsed_ns", android.os.SystemClock.elapsedRealtimeNanos());
                            if (saveYuv) queueYuv(image, id);
                            else if (saveFrames) saveLuma(image, id);
                        }
                    } catch (Exception error) { if (!stopped) fail("image", error); }
                }, handler);
                readers.add(reader);
                OutputConfiguration output = new OutputConfiguration(reader.getSurface());
                output.setPhysicalCameraId(id); outputs.add(output);
            }
            manager.openCamera(LOGICAL, new CameraDevice.StateCallback() {
                @Override public void onOpened(CameraDevice device) {
                    if (stopped) { device.close(); return; } camera = device;
                    emit("opened", "id", device.getId());
                    try {
                        SessionConfiguration configuration = new SessionConfiguration(SessionConfiguration.SESSION_REGULAR,
                            outputs, task -> handler.post(task), new CameraCaptureSession.StateCallback() {
                                @Override public void onConfigured(CameraCaptureSession configured) {
                                    if (stopped) { configured.close(); return; } session = configured;
                                    try {
                                        if (controlled) {
                                            requestControlled("auto");
                                            handler.postDelayed(() -> controlledStep("manual"), 10000);
                                            handler.postDelayed(() -> controlledStep("pulse"), 20000);
                                        } else requestPhase(10f);
                                        if (geometry && !controlled) handler.postDelayed(() -> {
                                            if (!stopped) try { requestPhase(1f); }
                                            catch (Exception error) { fail("native_request", error); }
                                        }, 5000);
                                    } catch (Exception error) { fail("request", error); }
                                }
                                @Override public void onConfigureFailed(CameraCaptureSession failed) {
                                    emit("configure_failed"); stop("configure_failed");
                                }
                            });
                        camera.createCaptureSession(configuration);
                    } catch (Exception error) { fail("session", error); }
                }
                @Override public void onDisconnected(CameraDevice device) { device.close(); stop("disconnected"); }
                @Override public void onError(CameraDevice device, int error) {
                    device.close(); if (!stopped) { emit("device_error", "code", error); stop("device_error"); }
                }
            }, handler);
        } catch (Exception error) { fail("inventory_or_open", error); }
    }

    private static boolean has(int[] values, int wanted) {
        if (values != null) for (int value : values) if (value == wanted) return true;
        return false;
    }

    private void prepareControls(CameraManager manager, CameraCharacteristics logical) throws Exception {
        List<CaptureRequest.Key<?>> available = logical.getAvailablePhysicalCameraRequestKeys();
        physicalKeys = available == null ? Collections.emptySet() : new HashSet<>(available);
        for (CaptureRequest.Key<?> key : Arrays.asList(CaptureRequest.CONTROL_AF_MODE,
                CaptureRequest.CONTROL_AE_MODE, CaptureRequest.CONTROL_AE_TARGET_FPS_RANGE))
            if (!physicalKeys.contains(key)) throw new IllegalStateException("Missing per-physical control: " + key);
        List<Range<Integer>> common = new ArrayList<>(Arrays.asList(logical.get(CameraCharacteristics.CONTROL_AE_AVAILABLE_TARGET_FPS_RANGES)));
        long exposureLow = 1, exposureHigh = Long.MAX_VALUE, minDuration = 1;
        int isoLow = 1, isoHigh = Integer.MAX_VALUE;
        manualSupported = true;
        for (String id : new String[]{MAIN, AUX}) {
            CameraCharacteristics c = manager.getCameraCharacteristics(id);
            physicalCharacteristics.put(id, c);
            common.retainAll(Arrays.asList(c.get(CameraCharacteristics.CONTROL_AE_AVAILABLE_TARGET_FPS_RANGES)));
            Range<Long> exposure = c.get(CameraCharacteristics.SENSOR_INFO_EXPOSURE_TIME_RANGE);
            Range<Integer> iso = c.get(CameraCharacteristics.SENSOR_INFO_SENSITIVITY_RANGE);
            manualSupported &= has(c.get(CameraCharacteristics.REQUEST_AVAILABLE_CAPABILITIES), CameraCharacteristics.REQUEST_AVAILABLE_CAPABILITIES_MANUAL_SENSOR);
            if (exposure == null || iso == null) manualSupported = false;
            else {
                exposureLow = Math.max(exposureLow, exposure.getLower()); exposureHigh = Math.min(exposureHigh, exposure.getUpper());
                isoLow = Math.max(isoLow, iso.getLower()); isoHigh = Math.min(isoHigh, iso.getUpper());
            }
            StreamConfigurationMap map = c.get(CameraCharacteristics.SCALER_STREAM_CONFIGURATION_MAP);
            minDuration = Math.max(minDuration, map.getOutputMinFrameDuration(ImageFormat.YUV_420_888, new Size(640, 480)));
        }
        common.removeIf(r -> r.getUpper() > 30 || r.getLower() < 10);
        common.sort((left, right) -> {
            boolean a = left.getLower().equals(left.getUpper()), b = right.getLower().equals(right.getUpper());
            return a == b ? Integer.compare(left.getUpper(), right.getUpper()) : a ? -1 : 1;
        });
        if (common.isEmpty()) throw new IllegalStateException("No common bounded FPS range");
        commonFps = common.get(0);
        frameNs = Math.max(minDuration, 1000000000L / commonFps.getUpper());
        exposureNs = Math.max(exposureLow, Math.min(30000000L, Math.min(exposureHigh, frameNs - 1000000L)));
        lowIso = Math.max(isoLow, Math.min(800, isoHigh));
        highIso = Math.max(isoLow, Math.min(3200, isoHigh));
        for (CaptureRequest.Key<?> key : Arrays.asList(CaptureRequest.SENSOR_EXPOSURE_TIME,
                CaptureRequest.SENSOR_FRAME_DURATION, CaptureRequest.SENSOR_SENSITIVITY)) manualSupported &= physicalKeys.contains(key);
        manualSupported &= exposureLow <= exposureHigh && exposureNs < frameNs && lowIso < highIso;
        emit("control_plan", "fps", commonFps.toString(), "frame_duration_ns", frameNs,
            "exposure_ns", exposureNs, "low_iso", lowIso, "high_iso", highIso, "manual_supported", manualSupported,
            "pulse_code", "31-slot PRBS; aux offset11; intensity is diagnostic only");
    }

    private void controlledStep(String phase) {
        if (!stopped) try { requestControlled(phase); } catch (Exception error) { fail("controlled_" + phase, error); }
    }

    private int afMode(String id) {
        int[] modes = physicalCharacteristics.get(id).get(CameraCharacteristics.CONTROL_AF_AVAILABLE_MODES);
        if (has(modes, CaptureRequest.CONTROL_AF_MODE_CONTINUOUS_PICTURE)) return CaptureRequest.CONTROL_AF_MODE_CONTINUOUS_PICTURE;
        if (has(modes, CaptureRequest.CONTROL_AF_MODE_CONTINUOUS_VIDEO)) return CaptureRequest.CONTROL_AF_MODE_CONTINUOUS_VIDEO;
        if (has(modes, CaptureRequest.CONTROL_AF_MODE_AUTO)) return CaptureRequest.CONTROL_AF_MODE_AUTO;
        throw new IllegalStateException("No physical autofocus mode for " + id);
    }

    private static boolean pulseHigh(int slot) {
        int state = 31;
        for (int i = 0; i <= slot % 31; i++) state = (state >> 1) | (((state ^ (state >> 2)) & 1) << 4);
        return (state & 1) != 0;
    }

    private float manualFocus(String id, String phase) {
        Float maximum = physicalCharacteristics.get(id).get(CameraCharacteristics.LENS_INFO_MINIMUM_FOCUS_DISTANCE);
        float value = focusedDistances.getOrDefault(id, 0.5f);
        // Small auxiliary perturbation tests independent focus control in pulse phase.
        if (phase.equals("pulse") && id.equals(AUX)) value += 0.05f;
        return Math.max(0f, Math.min(value, maximum == null ? value : maximum));
    }

    private CaptureRequest.Builder controlledRequest(String phase, int slot) throws Exception {
        CaptureRequest.Builder request = camera.createCaptureRequest(CameraDevice.TEMPLATE_PREVIEW, new HashSet<>(Arrays.asList(MAIN, AUX)));
        for (ImageReader reader : readers) request.addTarget(reader.getSurface());
        if (saveYuv) configureGeometryControls(request);
        request.set(CaptureRequest.CONTROL_ZOOM_RATIO, 1f);
        request.set(CaptureRequest.CONTROL_AE_TARGET_FPS_RANGE, commonFps);
        boolean manual = !phase.equals("auto");
        request.set(CaptureRequest.CONTROL_AE_MODE, manual ? CaptureRequest.CONTROL_AE_MODE_OFF : CaptureRequest.CONTROL_AE_MODE_ON);
        if (manual) {
            request.set(CaptureRequest.SENSOR_EXPOSURE_TIME, exposureNs);
            request.set(CaptureRequest.SENSOR_FRAME_DURATION, frameNs);
            request.set(CaptureRequest.SENSOR_SENSITIVITY, phase.equals("pulse") && pulseHigh(slot) ? highIso : lowIso);
            request.set(CaptureRequest.CONTROL_AF_MODE, CaptureRequest.CONTROL_AF_MODE_OFF);
            request.set(CaptureRequest.LENS_FOCUS_DISTANCE, manualFocus(MAIN, phase));
        }
        for (String id : new String[]{MAIN, AUX}) {
            request.setPhysicalCameraKey(CaptureRequest.CONTROL_AF_MODE, manual && physicalKeys.contains(CaptureRequest.LENS_FOCUS_DISTANCE) ? CaptureRequest.CONTROL_AF_MODE_OFF : afMode(id), id);
            if (manual && physicalKeys.contains(CaptureRequest.LENS_FOCUS_DISTANCE)) request.setPhysicalCameraKey(CaptureRequest.LENS_FOCUS_DISTANCE,
                manualFocus(id, phase), id);
            request.setPhysicalCameraKey(CaptureRequest.CONTROL_AE_MODE, manual ? CaptureRequest.CONTROL_AE_MODE_OFF : CaptureRequest.CONTROL_AE_MODE_ON, id);
            request.setPhysicalCameraKey(CaptureRequest.CONTROL_AE_TARGET_FPS_RANGE, commonFps, id);
            if (physicalKeys.contains(CaptureRequest.CONTROL_ZOOM_RATIO)) request.setPhysicalCameraKey(CaptureRequest.CONTROL_ZOOM_RATIO, 1f, id);
            if (physicalKeys.contains(CaptureRequest.SCALER_CROP_REGION)) request.setPhysicalCameraKey(CaptureRequest.SCALER_CROP_REGION,
                physicalCharacteristics.get(id).get(CameraCharacteristics.SENSOR_INFO_ACTIVE_ARRAY_SIZE), id);
            if (manual) {
                request.setPhysicalCameraKey(CaptureRequest.SENSOR_EXPOSURE_TIME, exposureNs, id);
                request.setPhysicalCameraKey(CaptureRequest.SENSOR_FRAME_DURATION, frameNs, id);
                int iso = phase.equals("pulse") && pulseHigh(slot + (id.equals(AUX) ? 11 : 0)) ? highIso : lowIso;
                request.setPhysicalCameraKey(CaptureRequest.SENSOR_SENSITIVITY, iso, id);
            }
        }
        request.setTag(phase.equals("pulse") ? "pulse_" + slot : phase);
        return request;
    }

    private void configureGeometryControls(CaptureRequest.Builder request) {
        // Only the explicit YUV diagnostic profile changes these requests.
        // Unsupported/null capabilities remain unknown; never invent a mode.
        List<CaptureRequest.Key<?>> logicalKeys = logicalCharacteristics.getAvailableCaptureRequestKeys();
        if (logicalKeys != null && logicalKeys.contains(CaptureRequest.LENS_OPTICAL_STABILIZATION_MODE) &&
                has(logicalCharacteristics.get(CameraCharacteristics.LENS_INFO_AVAILABLE_OPTICAL_STABILIZATION), 0))
            request.set(CaptureRequest.LENS_OPTICAL_STABILIZATION_MODE, 0);
        if (logicalKeys != null && logicalKeys.contains(CaptureRequest.CONTROL_VIDEO_STABILIZATION_MODE) &&
                has(logicalCharacteristics.get(CameraCharacteristics.CONTROL_AVAILABLE_VIDEO_STABILIZATION_MODES), 0))
            request.set(CaptureRequest.CONTROL_VIDEO_STABILIZATION_MODE, 0);
        if (logicalKeys != null && logicalKeys.contains(CaptureRequest.SCALER_ROTATE_AND_CROP) &&
                has(logicalCharacteristics.get(CameraCharacteristics.SCALER_AVAILABLE_ROTATE_AND_CROP_MODES), 0))
            request.set(CaptureRequest.SCALER_ROTATE_AND_CROP, 0);
        for (String id : new String[]{MAIN, AUX}) {
            CameraCharacteristics c = physicalCharacteristics.get(id);
            if (physicalKeys.contains(CaptureRequest.LENS_OPTICAL_STABILIZATION_MODE) &&
                    has(c.get(CameraCharacteristics.LENS_INFO_AVAILABLE_OPTICAL_STABILIZATION), 0))
                request.setPhysicalCameraKey(CaptureRequest.LENS_OPTICAL_STABILIZATION_MODE, 0, id);
            if (physicalKeys.contains(CaptureRequest.CONTROL_VIDEO_STABILIZATION_MODE) &&
                    has(c.get(CameraCharacteristics.CONTROL_AVAILABLE_VIDEO_STABILIZATION_MODES), 0))
                request.setPhysicalCameraKey(CaptureRequest.CONTROL_VIDEO_STABILIZATION_MODE, 0, id);
            if (physicalKeys.contains(CaptureRequest.SCALER_ROTATE_AND_CROP) &&
                    has(c.get(CameraCharacteristics.SCALER_AVAILABLE_ROTATE_AND_CROP_MODES), 0))
                request.setPhysicalCameraKey(CaptureRequest.SCALER_ROTATE_AND_CROP, 0, id);
        }
    }

    private void requestControlled(String phase) throws Exception {
        if (!phase.equals("auto") && !manualSupported) {
            emit("phase_skipped", "phase", phase, "reason", "manual sensor controls not jointly advertised"); return;
        }
        List<CaptureRequest> burst = new ArrayList<>();
        for (int slot = 0; slot < (phase.equals("pulse") ? 31 : 1); slot++) burst.add(controlledRequest(phase, slot).build());
        session.setRepeatingBurst(burst, captureCallback, handler);
        arrivalPhase = phase;
        phaseStarted = android.os.SystemClock.elapsedRealtime();
        emit("stream_request", "phase", phase, "zoom", 1f, "fps", commonFps.toString(), "burst_length", burst.size());
        // AUTO fallback needs one trigger, never repeat START on every frame.
        if (phase.equals("auto") && physicalKeys.contains(CaptureRequest.CONTROL_AF_TRIGGER)) {
            CaptureRequest.Builder trigger = controlledRequest(phase, 0);
            boolean needed = false;
            for (String id : new String[]{MAIN, AUX}) if (afMode(id) == CaptureRequest.CONTROL_AF_MODE_AUTO) {
                trigger.setPhysicalCameraKey(CaptureRequest.CONTROL_AF_TRIGGER, CaptureRequest.CONTROL_AF_TRIGGER_START, id); needed = true;
            }
            if (needed) session.capture(trigger.build(), captureCallback, handler);
        }
    }

    private String requestedIso(CaptureRequest request, String id) {
        String tag = String.valueOf(request.getTag());
        if (tag.equals("auto")) return "auto";
        int slot = tag.startsWith("pulse_") ? Integer.parseInt(tag.substring(6)) : 0;
        return String.valueOf(tag.startsWith("pulse_") && pulseHigh(slot + (id.equals(AUX) ? 11 : 0)) ? highIso : lowIso);
    }

    private static String phaseOf(CaptureRequest request) {
        String tag = String.valueOf(request.getTag());
        return tag.startsWith("pulse_") ? "pulse" : tag;
    }

    private static JSONObject lumaStats(Image image) throws Exception {
        Image.Plane plane = image.getPlanes()[0]; ByteBuffer data = plane.getBuffer().duplicate();
        int base = data.position(), count = 0; double sum = 0, square = 0, edges = 0;
        for (int y = 8; y < image.getHeight() - 8; y += 8) for (int x = 8; x < image.getWidth() - 8; x += 8) {
            int at = base + y * plane.getRowStride() + x * plane.getPixelStride();
            int value = data.get(at) & 255, previous = data.get(at - 8 * plane.getPixelStride()) & 255;
            sum += value; square += value * value; edges += Math.abs(value - previous); count++;
        }
        return new JSONObject().put("mean", sum/count).put("stddev", Math.sqrt(Math.max(0, square/count - sum*sum/count/count)))
            .put("edge_mean", edges/count).put("sample_count", count);
    }

    private void requestPhase(float zoom) throws Exception {
        CaptureRequest.Builder request = camera.createCaptureRequest(CameraDevice.TEMPLATE_PREVIEW);
        for (ImageReader reader : readers) request.addTarget(reader.getSurface());
        request.set(CaptureRequest.CONTROL_ZOOM_RATIO, zoom);
        String phase = zoom == 10f ? "zoom10" : "zoom1";
        request.setTag(phase);
        session.setRepeatingRequest(request.build(), captureCallback, handler);
        arrivalPhase = phase;
        phaseStarted = android.os.SystemClock.elapsedRealtime();
        emit("stream_request", "phase", phase, "zoom", zoom, "template", "PREVIEW", "format", "YUV_420_888");
    }

    private void saveLuma(Image image, String id) throws Exception {
        String group = arrivalPhase + "-" + id;
        Set<Long> selected = selectedSampleTicks.computeIfAbsent(arrivalPhase, k -> new HashSet<>());
        long elapsed = android.os.SystemClock.elapsedRealtime() - phaseStarted;
        long timestamp = image.getTimestamp();
        // Gate new auto samples on the most recent joint settled result. Exact
        // image/result timestamps are still validated on host; callback order
        // can place an image just before its own result at this10fps cadence.
        boolean focusReady = !saveYuv || !arrivalPhase.equals("auto") ||
            (settledPairAt != 0 && android.os.SystemClock.elapsedRealtime() - settledPairAt <= 250);
        if (!selected.contains(timestamp) && focusReady && selected.size() < 2 && elapsed >= 2500 &&
                elapsed - lastSampleAt.getOrDefault(arrivalPhase, 0L) >= 1500) {
            selected.add(timestamp); lastSampleAt.put(arrivalPhase, elapsed);
        }
        if (!selected.contains(timestamp)) return;
        int count = saved.getOrDefault(group, 0);
        if (count >= 2) return;
        // Arrival phase is advisory: match image timestamp to result timestamp on host.
        String name = runId + "-" + group + "-" + image.getTimestamp() + ".pgm";
        File file = new File(report.getParentFile(), name);
        Image.Plane plane = image.getPlanes()[0];
        ByteBuffer data = plane.getBuffer().duplicate();
        int base = data.position(), width = image.getWidth(), height = image.getHeight();
        byte[] row = new byte[width];
        try (FileOutputStream output = new FileOutputStream(file)) {
            output.write(("P5\n" + width + " " + height + "\n255\n").getBytes(StandardCharsets.US_ASCII));
            for (int y = 0; y < height; y++) {
                for (int x = 0; x < width; x++) row[x] = data.get(base + y * plane.getRowStride() + x * plane.getPixelStride());
                output.write(row);
            }
        }
        saved.put(group, count + 1);
        emit("saved_luma", "id", id, "timestamp_ns", image.getTimestamp(), "arrival_phase", arrivalPhase,
            "file", name, "width", width, "height", height, "row_stride", plane.getRowStride(),
            "pixel_stride", plane.getPixelStride());
    }

    private static final class YuvSample {
        final byte[] data;
        final JSONArray layouts;
        final int width, height;
        final String crop;
        final long timestamp;
        YuvSample(Image image, byte[] data, JSONArray layouts) {
            this.data = data; this.layouts = layouts; width = image.getWidth(); height = image.getHeight();
            crop = image.getCropRect().toString(); timestamp = image.getTimestamp();
        }
    }

    private YuvSample copyYuv(Image image) throws Exception {
        int width = image.getWidth(), height = image.getHeight();
        if (image.getFormat() != ImageFormat.YUV_420_888 || image.getPlanes().length != 3 ||
                (width & 1) != 0 || (height & 1) != 0) throw new IllegalStateException("Unsupported YUV layout");
        // Normalize actual Y/U/V planes to tight NV21; never substitute neutral chroma.
        byte[] nv21 = new byte[width * height * 3 / 2];
        JSONArray layouts = new JSONArray();
        for (int p = 0; p < 3; p++) {
            Image.Plane plane = image.getPlanes()[p];
            ByteBuffer buffer = plane.getBuffer().duplicate();
            int base = buffer.position(), rows = p == 0 ? height : height / 2;
            int columns = p == 0 ? width : width / 2;
            int stride = plane.getRowStride(), step = plane.getPixelStride();
            if (stride <= 0 || step <= 0 || base + (rows-1)*stride + (columns-1)*step >= buffer.limit())
                throw new IllegalStateException("Truncated source YUV plane");
            layouts.put(new JSONObject().put("plane", p).put("position", base).put("limit", buffer.limit())
                .put("row_stride", stride).put("pixel_stride", step));
            for (int y = 0; y < rows; y++) for (int x = 0; x < columns; x++) {
                int destination = p == 0 ? y * width + x : width * height + y * width + 2*x + (p == 1 ? 1 : 0);
                nv21[destination] = buffer.get(base + y * stride + x * step);
            }
        }
        return new YuvSample(image, nv21, layouts);
    }

    private void queueYuv(Image image, String id) throws Exception {
        long tick = image.getTimestamp();
        pendingYuv.computeIfAbsent(tick, key -> new HashMap<>()).put(id, copyYuv(image));
        while (pendingYuv.size() > 8) pendingYuv.remove(pendingYuv.keySet().iterator().next());
        saveReadyYuvPair(tick);
    }

    private void saveReadyYuvPair(long tick) throws Exception {
        Map<String, YuvSample> pair = pendingYuv.get(tick);
        String phase = yuvResultPhases.get(tick);
        if (phase == null || pair == null || !pair.containsKey(MAIN) || !pair.containsKey(AUX)) return;
        // Both image buffers and their exact logical result are available now.
        // Never predict timestamps or select one lens before its peer arrives.
        pendingYuv.remove(tick);
        if (!phase.equals(arrivalPhase) || savedYuvPairs.getOrDefault(phase, 0) >= 2 ||
                android.os.SystemClock.elapsedRealtime() - phaseStarted < 2500 ||
                tick - lastYuvSampleNs.getOrDefault(phase, 0L) < 1500000000L ||
                (phase.equals("auto") && !settledYuvResults.contains(tick))) return;
        for (String id : new String[]{MAIN, AUX}) writeYuvSample(pair.get(id), id, phase);
        savedYuvPairs.put(phase, savedYuvPairs.getOrDefault(phase, 0) + 1);
        lastYuvSampleNs.put(phase, tick);
    }

    private void writeYuvSample(YuvSample sample, String id, String phase) throws Exception {
        String stem = runId + "-" + phase + "-" + id + "-" + sample.timestamp;
        String name = stem + ".nv21";
        File file = new File(report.getParentFile(), name);
        if (!file.createNewFile()) throw new IllegalStateException("Refusing to replace YUV sample");
        try (FileOutputStream output = new FileOutputStream(file)) { output.write(sample.data); }
        emit("saved_yuv", "id", id, "timestamp_ns", sample.timestamp, "arrival_phase", phase,
            "file", name, "width", sample.width, "height", sample.height, "format", "NV21", "bytes", sample.data.length,
            "sha256", hash(sample.data), "image_crop", sample.crop, "source_planes", sample.layouts);
        String pgm = stem + ".pgm";
        File grayscale = new File(report.getParentFile(), pgm);
        if (!grayscale.createNewFile()) throw new IllegalStateException("Refusing to replace luma sample");
        try (FileOutputStream output = new FileOutputStream(grayscale)) {
            output.write(("P5\n" + sample.width + " " + sample.height + "\n255\n").getBytes(StandardCharsets.US_ASCII));
            output.write(sample.data, 0, sample.width * sample.height);
        }
        emit("saved_luma", "id", id, "timestamp_ns", sample.timestamp, "arrival_phase", phase,
            "file", pgm, "width", sample.width, "height", sample.height, "row_stride", sample.width, "pixel_stride", 1);
    }

    // Observe only keys actually returned by the provider. Do not invent vendor
    // key types or set sync/crop controls based on their names.
    private static Object boundedMetadataValue(Object value) throws Exception {
        if (value == null) return JSONObject.NULL;
        if (value.getClass().isArray()) {
            int length = java.lang.reflect.Array.getLength(value);
            JSONArray data = new JSONArray();
            for (int i = 0; i < Math.min(length, 128); i++)
                data.put(boundedMetadataValue(java.lang.reflect.Array.get(value, i)));
            return new JSONObject().put("length", length).put("values", data)
                .put("truncated", length > 128).put("type", value.getClass().getName());
        }
        if (value instanceof Number || value instanceof Boolean) return value;
        String text = String.valueOf(value);
        return new JSONObject().put("type", value.getClass().getName())
            .put("value", text.substring(0, Math.min(text.length(), 256)))
            .put("truncated", text.length() > 256);
    }

    private JSONObject vendorGeometryState(CaptureResult result) {
        JSONObject output = new JSONObject(), values = new JSONObject();
        JSONArray omitted = new JSONArray();
        int selected = 0;
        try {
            for (CaptureResult.Key<?> key : result.getKeys()) {
                String name = key.getName(), lower = name.toLowerCase(Locale.ROOT);
                if (lower.startsWith("android.") || !(lower.contains("crop") || lower.contains("sync") ||
                        lower.contains("sensormode") || lower.contains("pixelshift") || lower.contains("fov"))) continue;
                if (selected++ >= 40) { omitted.put(name); continue; }
                try { values.put(name, boundedMetadataValue(result.get(key))); }
                catch (Exception error) { values.put(name, new JSONObject().put("error", error.getClass().getName())); }
            }
            output.put("values", values).put("omitted_keys", omitted)
                .put("source", "returned_keys_only_no_logical_fallback");
        } catch (Exception error) {
            try { output.put("error", error.getClass().getName()); } catch (Exception ignored) { }
        }
        return output;
    }

    private final CameraCaptureSession.CaptureCallback captureCallback = new CameraCaptureSession.CaptureCallback() {
        @Override public void onCaptureCompleted(CameraCaptureSession s, CaptureRequest q, TotalCaptureResult r) {
            if (stopped) return; results++;
            Map<String, CaptureResult> physical = r.getPhysicalCameraResults();
            boolean jointlySettled = physical.containsKey(MAIN) && physical.containsKey(AUX);
            for (String id : new String[]{MAIN, AUX}) {
                CaptureResult value = physical.get(id);
                Integer af = value == null ? null : value.get(CaptureResult.CONTROL_AF_STATE);
                Integer lens = value == null ? null : value.get(CaptureResult.LENS_STATE);
                jointlySettled &= af != null && (af == 2 || af == 4) && lens != null && lens == 0;
            }
            settledPairAt = jointlySettled && phaseOf(q).equals("auto") ? android.os.SystemClock.elapsedRealtime() : 0;
            if (saveYuv) {
                Long tick = r.get(CaptureResult.SENSOR_TIMESTAMP);
                if (tick != null) {
                    yuvResultPhases.put(tick, phaseOf(q));
                    if (jointlySettled) settledYuvResults.add(tick);
                    while (yuvResultPhases.size() > 8) {
                        Long old = yuvResultPhases.keySet().iterator().next();
                        yuvResultPhases.remove(old); settledYuvResults.remove(old);
                    }
                    try { saveReadyYuvPair(tick); } catch (Exception error) { fail("save_yuv_pair", error); return; }
                }
            }
            if (physical.containsKey(MAIN) && physical.containsKey(AUX)) pairedResults.add(r.getFrameNumber());
            if (geometry || results <= 5) {
                if (saveYuv) emit("logical_processing_result", "frame", r.getFrameNumber(),
                    "timestamp_ns", String.valueOf(r.get(CaptureResult.SENSOR_TIMESTAMP)),
                    "phase", phaseOf(q), "source", "logical_result_not_physical_fallback",
                    "vendor_geometry", vendorGeometryState(r),
                    "requested_ois", String.valueOf(q.get(CaptureRequest.LENS_OPTICAL_STABILIZATION_MODE)),
                    "requested_video_stabilization", String.valueOf(q.get(CaptureRequest.CONTROL_VIDEO_STABILIZATION_MODE)),
                    "requested_rotate_and_crop", String.valueOf(q.get(CaptureRequest.SCALER_ROTATE_AND_CROP)),
                    "ois_mode", String.valueOf(r.get(CaptureResult.LENS_OPTICAL_STABILIZATION_MODE)),
                    "video_stabilization_mode", String.valueOf(r.get(CaptureResult.CONTROL_VIDEO_STABILIZATION_MODE)),
                    "rotate_and_crop", String.valueOf(r.get(CaptureResult.SCALER_ROTATE_AND_CROP)),
                    "distortion_correction_mode", String.valueOf(r.get(CaptureResult.DISTORTION_CORRECTION_MODE)),
                    "distortion", Arrays.toString(r.get(CaptureResult.LENS_DISTORTION)),
                    "crop", String.valueOf(r.get(CaptureResult.SCALER_CROP_REGION)),
                    "intrinsics", Arrays.toString(r.get(CaptureResult.LENS_INTRINSIC_CALIBRATION)));
                emit("result", "phase", phaseOf(q), "frame", r.getFrameNumber(), "timestamp_ns", String.valueOf(r.get(CaptureResult.SENSOR_TIMESTAMP)),
                    "physical_results", new JSONArray(physical.keySet()), "request_tag", String.valueOf(q.getTag()));
                for (Map.Entry<String, CaptureResult> entry : physical.entrySet()) {
                    Integer state = entry.getValue().get(CaptureResult.CONTROL_AF_STATE);
                    Float distance = entry.getValue().get(CaptureResult.LENS_FOCUS_DISTANCE);
                    if (controlled && phaseOf(q).equals("auto") && state != null && (state == 2 || state == 4) && distance != null)
                        focusedDistances.put(entry.getKey(), distance);
                    emit("physical_result", "phase", phaseOf(q), "id", entry.getKey(),
                    "frame", r.getFrameNumber(), "timestamp_ns", String.valueOf(entry.getValue().get(CaptureResult.SENSOR_TIMESTAMP)),
                    "vendor_geometry", vendorGeometryState(entry.getValue()),
                    "focal_length", String.valueOf(entry.getValue().get(CaptureResult.LENS_FOCAL_LENGTH)),
                    "crop", String.valueOf(entry.getValue().get(CaptureResult.SCALER_CROP_REGION)),
                    "zoom", String.valueOf(entry.getValue().get(CaptureResult.CONTROL_ZOOM_RATIO)),
                    "exposure_ns", String.valueOf(entry.getValue().get(CaptureResult.SENSOR_EXPOSURE_TIME)),
                    "frame_duration_ns", String.valueOf(entry.getValue().get(CaptureResult.SENSOR_FRAME_DURATION)),
                    "rolling_shutter_skew_ns", String.valueOf(entry.getValue().get(CaptureResult.SENSOR_ROLLING_SHUTTER_SKEW)),
                    "intrinsics", Arrays.toString(entry.getValue().get(CaptureResult.LENS_INTRINSIC_CALIBRATION)),
                    "distortion", Arrays.toString(entry.getValue().get(CaptureResult.LENS_DISTORTION)),
                    "distortion_correction_mode", String.valueOf(entry.getValue().get(CaptureResult.DISTORTION_CORRECTION_MODE)),
                    "rotate_and_crop", String.valueOf(entry.getValue().get(CaptureResult.SCALER_ROTATE_AND_CROP)),
                    "ois_mode", String.valueOf(entry.getValue().get(CaptureResult.LENS_OPTICAL_STABILIZATION_MODE)),
                    "video_stabilization_mode", String.valueOf(entry.getValue().get(CaptureResult.CONTROL_VIDEO_STABILIZATION_MODE)),
                    "af_mode", String.valueOf(entry.getValue().get(CaptureResult.CONTROL_AF_MODE)),
                    "af_state", String.valueOf(entry.getValue().get(CaptureResult.CONTROL_AF_STATE)),
                    "focus_diopters", String.valueOf(entry.getValue().get(CaptureResult.LENS_FOCUS_DISTANCE)),
                    "lens_state", String.valueOf(entry.getValue().get(CaptureResult.LENS_STATE)),
                    "ae_mode", String.valueOf(entry.getValue().get(CaptureResult.CONTROL_AE_MODE)),
                    "ae_state", String.valueOf(entry.getValue().get(CaptureResult.CONTROL_AE_STATE)),
                    "iso", String.valueOf(entry.getValue().get(CaptureResult.SENSOR_SENSITIVITY)),
                    "fps", String.valueOf(entry.getValue().get(CaptureResult.CONTROL_AE_TARGET_FPS_RANGE)),
                    "requested_af_mode", controlled ? (phaseOf(q).equals("auto") || !physicalKeys.contains(CaptureRequest.LENS_FOCUS_DISTANCE) ? String.valueOf(afMode(entry.getKey())) : "0") : "not_requested",
                    "requested_focus_diopters", controlled && !phaseOf(q).equals("auto") && physicalKeys.contains(CaptureRequest.LENS_FOCUS_DISTANCE) ? String.valueOf(manualFocus(entry.getKey(), phaseOf(q))) : "auto",
                    "requested_iso", controlled ? requestedIso(q, entry.getKey()) : "not_requested",
                    "request_tag", String.valueOf(q.getTag()));
                }
            }
        }
        @Override public void onCaptureFailed(CameraCaptureSession s, CaptureRequest q, CaptureFailure failure) {
            if (!stopped) { emit("capture_failed", "reason", failure.getReason(), "frame", failure.getFrameNumber()); stop("capture_failed"); }
        }
    };

    private void stop(String reason) {
        if (stopped) return; stopped = true;
        handler.removeCallbacks(timeout);
        if (session != null) session.close();
        if (camera != null) camera.close();
        for (ImageReader reader : readers) reader.close();
        Set<Long> a = images.getOrDefault(MAIN, Collections.emptySet()), b = images.getOrDefault(AUX, Collections.emptySet());
        Set<Long> matched = new HashSet<>(a); matched.retainAll(b);
        emit("summary", "reason", reason, "main_images", a.size(), "aux_images", b.size(), "results", results,
            "exact_timestamp_matches", matched.size(), "frames_with_both_physical_results", pairedResults.size(),
            "calibration_validated", false, "depth_validated", false);
        UI.post(() -> {
            owner.getApplication().unregisterActivityLifecycleCallbacks(this);
            synchronized (InAppPortraitPairProbe.class) { if (active == this) active = null; }
        });
        // Keep callbacks alive briefly so a late onOpened can close its device.
        handler.postDelayed(worker::quitSafely, 3000);
    }
    @Override public void onActivityPaused(Activity activity) {
        if (activity == owner) handler.post(() -> stop("owner_paused"));
    }
    @Override public void onActivityDestroyed(Activity activity) {
        if (activity == owner) handler.post(() -> stop("owner_destroyed"));
    }
    @Override public void onActivityCreated(Activity a, Bundle b) { }
    @Override public void onActivityStarted(Activity a) { }
    @Override public void onActivityResumed(Activity a) { }
    @Override public void onActivityStopped(Activity a) { }
    @Override public void onActivitySaveInstanceState(Activity a, Bundle b) { }
}
