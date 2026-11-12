// SPDX-License-Identifier: Apache-2.0
// Isolated stock DeviceParam getters. No Camera/engine/plugin initialization.
// Launcher MUST verify the exact stock plugin SHA256 before execution.
#define _GNU_SOURCE
#include <dlfcn.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <sys/resource.h>
#include <unistd.h>

typedef int32_t (*DeviceId)(void);
typedef void (*Constructor)(void *, uint32_t, int32_t);
typedef int32_t (*Project)(const void *);
typedef void (*Crop)(float, const void *, int32_t, int32_t,
                     int32_t *, int32_t *, int32_t *, int32_t *, uint32_t, uint32_t);

int main(void) {
    const struct rlimit limit = {0, 0};
    setrlimit(RLIMIT_CORE, &limit); alarm(20); setbuf(stdout, NULL);
    void *lib = dlopen("/system/lib64/libDualCamBokehCapture.camera.samsung.so", RTLD_NOW | RTLD_LOCAL);
    if (!lib) { fprintf(stderr, "%s\n", dlerror()); return 65; }
    void *symbol = dlsym(lib, "getVersionCode");
    Dl_info identity;
    if (!symbol || !dladdr(symbol, &identity)) return 66;
    uintptr_t base = (uintptr_t)identity.dli_fbase;
    if ((uintptr_t)symbol - base != 0x384e4) return 66;
    const uint32_t anchor[] = {0xd102c3ff, 0xa9077bfd, 0xf90043f7, 0xa90957f6};
    if (memcmp((const void *)(base + 0x3a7bc), anchor, sizeof(anchor))) return 66;
    int32_t sub = ((DeviceId)(base + 0x3a7bc))();
    int32_t device = ((DeviceId)(base + 0x3a9b4))();
    printf("{\"event\":\"device_selection\",\"device_id\":%d,\"sub_id\":%d,"
           "\"scope\":\"isolated_native_property_readers_not_Camera_state\"}\n", device, sub);
    // Explicitly test the recovered Diamond class, rather than pretending the
    // property reader instantiated a production Camera plugin for us.
    _Alignas(16) unsigned char object[0x400] = {0};
    ((Constructor)(base + 0x3c4e0))(object, 1, sub);
    uintptr_t *vtable;
    memcpy(&vtable, object, sizeof(vtable));
    if ((uintptr_t)vtable != base + 0x70c48 || vtable[0x98/8] != base + 0x414bc ||
            vtable[0x20/8] != base + 0x410d0) return 66;
    int32_t project = ((Project)vtable[0x98/8])(object);
    printf("{\"event\":\"diamond_profile\",\"project_id\":%d,"
           "\"production_class_selection_observed\":false}\n", project);
    for (int role = 2; role <= 5; role++) {
        if (role == 4) continue;
        int32_t mw = -1, mh = -1, aw = -1, ah = -1;
        ((Crop)vtable[0x20/8])(1.0f, object, role, 0, &mw, &mh, &aw, &ah, 0, 0);
        printf("{\"event\":\"uncropped_image_info\",\"role\":%d,\"main\":[%d,%d],"
               "\"aux\":[%d,%d],\"aspect_index\":0,\"tof\":false}\n", role, mw, mh, aw, ah);
    }
    // Diamond has a trivial destructor; this stack object owns no allocations.
    dlclose(lib);
    return 0;
}
