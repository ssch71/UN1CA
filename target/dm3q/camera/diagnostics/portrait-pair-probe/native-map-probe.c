// SPDX-License-Identifier: Apache-2.0
// Exact-engine, isolated map-setup probe. No cameras, pixels, or disparity calls.
// Launcher MUST verify the installed library SHA256 before executing this file.
#define _GNU_SOURCE
#include <dlfcn.h>
#include <inttypes.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/resource.h>
#include <unistd.h>

typedef struct { void *data; int32_t bytes, padding; } Calibration;
typedef int32_t (*Init)(void **, int32_t, int32_t);
typedef int32_t (*Set)(void *, const void *);
typedef int32_t (*Uninit)(void **);
typedef int32_t (*SetInteger)(void *, int32_t);
typedef int64_t (*Setup)(void *, const void *, const void *, int32_t);
_Static_assert(sizeof(Calibration) == 16 && sizeof(void *) == 8, "arm64 only");

static int readable(const void *p, size_t bytes) {
    // Android arm64 heap pointers may carry a TBI tag; /proc/maps uses VAs.
    uintptr_t address = (uintptr_t)p & UINT64_C(0x00ffffffffffffff);
    if (!address || bytes > SIZE_MAX-address) return 0;
    FILE *f = fopen("/proc/self/maps", "r");
    if (!f) return 0;
    char line[1024], mode[8];
    uintptr_t low, high;
    int found = 0;
    while (fgets(line, sizeof(line), f)) {
        if (sscanf(line, "%" SCNxPTR "-%" SCNxPTR " %7s", &low, &high, mode) == 3 &&
            mode[0] == 'r' && address >= low && address+bytes <= high) { found=1; break; }
    }
    fclose(f);
    return found;
}

static void read_at(const void *p, size_t offset, void *out, size_t size) {
    const unsigned char *q = (const unsigned char *)p + offset;
    if (!readable(q, size)) { fprintf(stderr, "Unreadable field +%zx\n", offset); exit(70); }
    memcpy(out, q, size);
}
static int32_t i32(const void *p, size_t offset) { int32_t v; read_at(p,offset,&v,4); return v; }
static int select_project(void *lib, void *handle, int project) {
    if (!project) return 0; // Preserve historical engine default unless explicit.
    SetInteger set_project=(SetInteger)dlsym(lib,"ARC_DCIR_SetProjectId");
    if (!set_project) return 66;
    int rc=set_project(handle,project);
    printf("{\"event\":\"set_project\",\"requested\":%d,\"rc\":%d,\"observed\":%d}\n",
           project,rc,i32(handle,0x5704));
    return rc ? rc : i32(handle,0x5704)==project ? 0 : 66;
}
static int64_t i64(const void *p, size_t offset) { int64_t v; read_at(p,offset,&v,8); return v; }
static void *ptr(const void *p, size_t offset) { void *v; read_at(p,offset,&v,8); return v; }
static void number(float value) {
    if (isfinite(value)) printf("%.9g", (double)value); else printf("null");
}
static void floats(const char *name, const void *p, size_t offset, size_t count) {
    printf("{\"event\":\"float_fields\",\"name\":\"%s\",\"offset\":%zu,\"values\":",name,offset);
    if (!p) { puts("null}"); return; }
    printf("[");
    for (size_t j=0;j<count;j++) { float v; read_at(p,offset+j*4,&v,4); if(j)printf(","); number(v); }
    puts("]}");
}
static void state(const char *phase, const void *h) {
    void *c = ptr(h,0);
    printf("{\"event\":\"state\",\"phase\":\"%s\",\"gate_distance_raw\":%d,"
           "\"capture_mode\":%d,\"distortion_available\":%d,\"project_id\":%d,"
           "\"model_selector\":%d,\"setup_bypass\":%" PRId64 ","
           "\"table_flag\":%" PRId64 ",\"mix_flag\":%" PRId64 ","
           "\"alternate_map_flag\":%" PRId64 ",\"extended_map_flag\":%" PRId64 ","
           "\"main_split_index\":%d,\"aux_split_index\":%d,\"maps_ready\":%" PRId64 "}\n",
           phase,i32(h,0x881c),i32(h,0x8868),i32(h,0xc0),i32(h,0x5704),i32(h,0x8894),
           i64(h,0x28),i64(c,0x890),i64(c,0x898),i64(c,0x8a0),i64(c,0x8f8),
           i32(c,0x8a8),i32(c,0x8ac),i64(c,0x870));
    floats("wrapper_calibration_f30",h,0x38,30);
    floats("core_calibration_f30",ptr(c,0x670),0,30);
    floats("normalized_calibration_f30",ptr(c,0x878),0,30);
    void *crop = ptr(c,0x678);
    if(crop) {
        printf("{\"event\":\"crop_config\",\"kind\":%" PRId64 ",\"words\":[",i64(crop,0));
        for(size_t j=0;j<16;j++){if(j)printf(",");printf("%d",i32(crop,j*4));} puts("]}");
        floats("crop_config_float_view",crop,0,16);
        floats("optional_euler_correction",crop,0x34,3);
    }
    floats("main_table_11_and_center",ptr(c,0x880),0,13);
    floats("aux_table_11_and_center",ptr(c,0x888),0,13);
}

static int dump_map(const void *core, size_t xo, size_t yo, const char *name, int w, int h) {
    if(w<1 || h<1 || w>4096 || h>4096) return 0;
    const float *x=ptr(core,xo), *y=ptr(core,yo);
    if(!readable(x,(size_t)w*h*4) || !readable(y,(size_t)w*h*4)) return 0;
    printf("{\"event\":\"map\",\"name\":\"%s\",\"width\":%d,\"height\":%d,\"samples\":[",name,w,h);
    for(int j=0;j<9;j++) {
        int u=(j%3)*(w-1)/2, v=(j/3)*(h-1)/2;
        if(j)printf(","); printf("{\"u\":%d,\"v\":%d,\"source_x\":",u,v);
        number(x[(size_t)v*w+u]);printf(",\"source_y\":");number(y[(size_t)v*w+u]);printf("}");
    }
    puts("]}");return 1;
}

static int export_plane(const void *core, size_t offset, const char *folder, const char *name, int w, int h) {
    if(w<1 || h<1 || w>4096 || h>4096)return 0;
    size_t count=(size_t)w*h;const void *data=ptr(core,offset);
    if(!readable(data,count*4))return 0;
    char path[1024];int n=snprintf(path,sizeof(path),"%s/%s.f32",folder,name);
    if(n<0 || (size_t)n>=sizeof(path))return 0;
    FILE *out=fopen(path,"wbx");if(!out)return 0;
    int ok=fwrite(data,4,count,out)==count;if(fclose(out))ok=0;
    return ok;
}

int main(int argc,char **argv) {
    setbuf(stdout,NULL);
    struct rlimit core_limit={0,0}; setrlimit(RLIMIT_CORE,&core_limit); alarm(30);
    if(argc<2 || argc>4) {fprintf(stderr,"usage: native-map-probe CALIBRATION_760_BYTES [NEW_MAP_OUTPUT_DIRECTORY [PROJECT_48_OR_49]]\n");return 64;}
    int project=0;
    if(argc==4) {
        if(strcmp(argv[3],"48") && strcmp(argv[3],"49"))return 64;
        project=atoi(argv[3]);
    }
    unsigned char data[761]; FILE *f=fopen(argv[1],"rb");
    if(!f){perror("calibration");return 65;}
    size_t n=fread(data,1,sizeof(data),f);int bad=ferror(f);fclose(f);
    if(bad||n!=760)return 65;
    void *lib=dlopen("/system/lib64/libdualcam_refocus_image.so",RTLD_NOW|RTLD_LOCAL);
    if(!lib){fprintf(stderr,"%s\n",dlerror());return 66;}
    Init init=(Init)dlsym(lib,"ARC_DCIR_InitEx");
    Set set=(Set)dlsym(lib,"ARC_DCIR_SetCaliData"), info=(Set)dlsym(lib,"ARC_DCIR_SetCameraImageInfo");
    Uninit uninit=(Uninit)dlsym(lib,"ARC_DCIR_Uninit");
    Dl_info identity;
    if(!init||!set||!info||!uninit||!dladdr((void *)info,&identity))return 66;
    uintptr_t base=(uintptr_t)identity.dli_fbase;
    if((uintptr_t)info-base!=0x1c3d1c4)return 66;
    unsigned char *entry=(unsigned char *)(base+0x1c405e4);
    const uint32_t anchor[]={0x6db923e9,0xa9017bfd,0xf90013fc,0xa90367fa};
    if(!readable(entry,sizeof(anchor))||memcmp(entry,anchor,sizeof(anchor)))return 66;
    Setup setup=(Setup)entry;
    printf("{\"event\":\"begin\",\"pid\":%d,\"profile\":\"InitEx(1,4); image-info before calibration\","
           "\"scope\":\"isolated_dimensions_only_map_setup\",\"camera_runtime_observed\":false,"
           "\"orientation\":90,\"buffer_size\":[640,480],\"crop_size\":[3648,2736]}\n",getpid());
    void *handle=NULL;int rc=init(&handle,1,4);
    printf("{\"event\":\"init\",\"rc\":%d}\n",rc);
    int status=1;
    if(rc||!handle)goto finish;
    rc=select_project(lib,handle,project);
    if(rc)goto finish;
    int32_t crops[]={3648,2736,3648,2736};rc=info(handle,crops);
    printf("{\"event\":\"set_image_info\",\"rc\":%d}\n",rc);
    if(rc)goto finish;
    Calibration calibration={data,760,0};rc=set(handle,&calibration);
    printf("{\"event\":\"set_calibration\",\"rc\":%d}\n",rc);
    if(rc)goto finish;
    state("before_setup",handle);
    // Only width/height are read by this traced setup path. No pixel API called.
    int32_t dimensions[20]={0};dimensions[1]=640;dimensions[2]=480;
    int64_t result=setup(handle,dimensions,dimensions,90);
    printf("{\"event\":\"geometry_setup\",\"rc\":%" PRId64 "}\n",result);
    state("after_setup",handle);
    if(!result) {
        void *c=ptr(handle,0);int w=i32(c,0x908),h=i32(c,0x90c);
        printf("{\"event\":\"map_layout\",\"aux_padding_x\":%d,\"aux_padding_y\":%d,"
               "\"base_width\":%d,\"base_height\":%d,\"aux_width\":%d,\"aux_height\":%d}\n",
               i32(c,0x900),i32(c,0x904),i32(c,0x910),i32(c,0x914),w,h);
        int ok=dump_map(c,0x818,0x820,"main",i32(c,0x910),i32(c,0x914));
        ok &= dump_map(c,0x828,0x830,"aux",w,h);
        ok &= dump_map(c,0x838,0x840,"main_secondary",i32(c,0xbfc),i32(c,0xbf8));
        if(argc>=3) {
            ok &= export_plane(c,0x818,argv[2],"main-x",i32(c,0x910),i32(c,0x914));
            ok &= export_plane(c,0x820,argv[2],"main-y",i32(c,0x910),i32(c,0x914));
            ok &= export_plane(c,0x828,argv[2],"aux-x",w,h);
            ok &= export_plane(c,0x830,argv[2],"aux-y",w,h);
            printf("{\"event\":\"map_export\",\"ok\":%s,\"format\":\"little_endian_float32\"}\n",ok?"true":"false");
        }
        status=ok?0:1;
    }
finish:
    if(handle){rc=uninit(&handle);printf("{\"event\":\"uninit\",\"rc\":%d,\"released\":%s}\n",rc,handle?"false":"true");if(rc||handle)status=1;}
    dlclose(lib);return status;
}
