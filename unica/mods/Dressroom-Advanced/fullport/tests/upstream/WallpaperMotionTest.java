package dev.denver.dressroomadvanced;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.concurrent.atomic.AtomicReference;

public final class WallpaperMotionTest {
    private static int checks;
    private static void check(boolean value, String message) {
        if (!value) throw new AssertionError(message);
        checks++;
    }

    private static WallpaperMotionPacket.Frame frame(int id, int which, float scale) {
        return new WallpaperMotionPacket.Frame(0, id, which, 1440, 3120,
                scale, scale, (1 - scale) / 2, (1 - scale) / 2);
    }

    public static void main(String[] args) throws Exception {
        ByteBuffer memory = ByteBuffer.allocateDirect(WallpaperMotionPacket.SIZE)
                .order(ByteOrder.nativeOrder());
        int phone = WallpaperMotionPacket.slot(6), fold = WallpaperMotionPacket.slot(18);
        check(WallpaperMotionPacket.read(memory, phone) == null, "Unwritten record is valid");
        check(WallpaperMotionPacket.write(memory, frame(47, 6, 1.05f)), "Initial frame not written");
        var initial = WallpaperMotionPacket.read(memory, phone);
        check(initial != null && initial.scaleX() == 1.05f, "Lost matrix values");
        check(initial.fits(47, 1080, 2340), "Resolution scaling rejected");
        check(!initial.fits(48, 1440, 3120), "Previous wallpaper accepted");
        check(!initial.fits(47, 3120, 1440), "Wrong orientation accepted");
        check(!initial.fits(47, 0, 0), "Unmeasured viewport accepted");
        check(!WallpaperMotionPacket.write(memory, frame(47, 6, 1.05f)), "Static frame wakes readers");
        check(WallpaperMotionPacket.write(memory, frame(90, 18, 1)), "Fold frame not written");
        check(WallpaperMotionPacket.read(memory, fold).wallpaper() == 90, "Fold slot missing");
        check(WallpaperMotionPacket.read(memory, phone).wallpaper() == 47, "Fold overwrote phone slot");
        check(WallpaperMotionPacket.slot(2) == phone, "Legacy lock selector has a different slot");
        check(!WallpaperMotionPacket.write(memory, frame(47, 5, 1)), "Home engine accepted");
        check(!WallpaperMotionPacket.write(memory, frame(47, 22, 1)), "Multiple screens accepted");
        check(!WallpaperMotionPacket.write(memory, frame(47, 6, Float.NaN)), "NaN accepted");
        check(!WallpaperMotionPacket.write(memory, frame(47, 6, 50)), "Unbounded scale accepted");

        ByteBuffer readOnly = memory.asReadOnlyBuffer().order(ByteOrder.nativeOrder());
        check(WallpaperMotionPacket.read(readOnly, phone).wallpaper() == 47, "Read-only mapping failed");
        int offset = phone * WallpaperMotionPacket.STRIDE;
        memory.putInt(offset, 3);
        check(WallpaperMotionPacket.read(memory, phone) == null, "Torn frame accepted");
        memory.putInt(offset, -2);
        check(WallpaperMotionPacket.write(memory, frame(47, 6, 1)), "Sequence rollover failed");
        check(WallpaperMotionPacket.read(memory, phone).revision() == 2, "Rollover became unwritten");

        AtomicReference<Throwable> failure = new AtomicReference<>();
        Runnable writer = () -> {
            try {
                for (int i = 0; i < 10000; i++) {
                    float scale = (i & 1) == 0 ? 1 : 1.05f;
                    WallpaperMotionPacket.write(memory, frame(scale == 1 ? 1 : 2, 6, scale));
                }
            } catch (Throwable error) { failure.set(error); }
        };
        Thread a = new Thread(writer), b = new Thread(writer);
        a.start(); b.start();
        while (a.isAlive() || b.isAlive()) {
            var current = WallpaperMotionPacket.read(readOnly, phone);
            if (current != null && current.wallpaper() <= 2
                    && (current.wallpaper() == 1) != (current.scaleX() == 1))
                throw new AssertionError("Concurrent writers published a mixed frame");
        }
        a.join(); b.join();
        check(failure.get() == null, "Concurrent writer failed: " + failure.get());
        check(WallpaperMotionPacket.read(memory, phone) != null, "Final record is incomplete");
        System.out.println("Wallpaper motion protocol: " + checks + " checks passed");
    }
}
