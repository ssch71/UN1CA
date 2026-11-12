// SPDX-License-Identifier: Apache-2.0
// Isolated public depth API exerciser for real, verified640x480 NV21 captures.
// Launcher must verify engine/calibration/inputs and alignment before execution.
#define main map_probe_main
#include "native-map-probe.c"
#undef main
#include <stddef.h>

typedef struct {
    uint32_t format; int32_t width,height,pad;
    void *planes[4]; int32_t pitches[4];
    void *metadata; int32_t metadata_bytes,pad2;
} Offscreen;
typedef struct { int32_t orientation,pad; void *face_rects,*face_angles; int32_t face_count,pad2; } DepthParam;
typedef int32_t (*Calc)(void *,const Offscreen *,const Offscreen *,const DepthParam *);
typedef int32_t (*LogLevel)(int32_t);
_Static_assert(offsetof(Offscreen,planes)==16 && offsetof(Offscreen,pitches)==48 && sizeof(Offscreen)==80,"image ABI");
_Static_assert(offsetof(DepthParam,face_count)==24 && sizeof(DepthParam)==32,"public depth param ABI");

static int read_exact_file(const char *name,void *buffer,size_t count) {
    FILE *f=fopen(name,"rb");if(!f)return 0;
    int ok=fread(buffer,1,count,f)==count && fgetc(f)==EOF && !ferror(f);fclose(f);return ok;
}
int main(int argc,char **argv) {
    setbuf(stdout,NULL);struct rlimit limit={0,0};setrlimit(RLIMIT_CORE,&limit);alarm(60);
    if(argc<5 || argc>7){fprintf(stderr,"usage: native-depth-probe CAL MAIN_NV21 AUX_NV21 NEW_DEPTH_PGM [PROJECT_48_OR_49 [MAIN_ISO]]\n");return 64;}
    int project=0;
    if(argc>=6) {
        if(strcmp(argv[5],"48") && strcmp(argv[5],"49"))return 64;
        project=atoi(argv[5]);
    }
    unsigned char cal[760];size_t pixels=640*480, bytes=pixels*3/2;
    unsigned char *main_yuv=malloc(bytes),*aux_yuv=malloc(bytes);
    if(!main_yuv||!aux_yuv||!read_exact_file(argv[1],cal,760)||!read_exact_file(argv[2],main_yuv,bytes)||!read_exact_file(argv[3],aux_yuv,bytes))return 65;
    void *lib=dlopen("/system/lib64/libdualcam_refocus_image.so",RTLD_NOW|RTLD_LOCAL);
    if(!lib){fprintf(stderr,"%s\n",dlerror());return 66;}
    // Changes only this isolated helper's library state, never global properties.
    LogLevel log_level=(LogLevel)dlsym(lib,"ARC_DCIR_SetLogLevel");
    if(!log_level)return 66;
    printf("{\"event\":\"depth_probe\",\"pid\":%d,\"log_level_rc\":%d}\n",getpid(),log_level(2));
    Init init=(Init)dlsym(lib,"ARC_DCIR_InitEx");Set set=(Set)dlsym(lib,"ARC_DCIR_SetCaliData");
    Set info=(Set)dlsym(lib,"ARC_DCIR_SetCameraImageInfo"), get=(Set)dlsym(lib,"ARC_DCIR_GetDisparityData");
    Calc calc=(Calc)dlsym(lib,"ARC_DCIR_CalcDisparityData");Uninit uninit=(Uninit)dlsym(lib,"ARC_DCIR_Uninit");
    if(!init||!set||!info||!get||!calc||!uninit)return 66;
    void *h=NULL;int status=1,rc=init(&h,1,4);printf("{\"event\":\"init\",\"rc\":%d}\n",rc);
    if(rc||!h)goto finish;
    rc=select_project(lib,h,project);if(rc)goto finish;
    int32_t crops[]={3648,2736,3648,2736};rc=info(h,crops);if(rc)goto finish;
    Calibration c={cal,760,0};rc=set(h,&c);printf("{\"event\":\"set_calibration\",\"rc\":%d}\n",rc);if(rc)goto finish;
    if(argc==7) {
        char *end=NULL;long iso=strtol(argv[6],&end,10);
        if(!end || *end || iso<50 || iso>3200)goto finish;
        Set capture=(Set)dlsym(lib,"ARC_DCIR_SetCaptureParam");
        SetInteger mode=(SetInteger)dlsym(lib,"ARC_DCIR_SetCaptureMode");
        if(!capture || !mode)goto finish;
        // Traced donor input words [Qualcomm device mode1, measured main ISO].
        int32_t values[]={1,(int32_t)iso};rc=mode(h,1);
        if(!rc)rc=capture(h,values);
        printf("{\"event\":\"capture_context\",\"rc\":%d,\"iso\":%d,\"device_mode\":%d,\"capture_mode\":%d}\n",
               rc,i32(h,0x8870),i32(h,0x8874),i32(h,0x8868));
        if(rc || i32(h,0x8870)!=iso || i32(h,0x8874)!=1 || i32(h,0x8868)!=1)goto finish;
    }
    Offscreen images[2]={{0}};unsigned char *data[]={main_yuv,aux_yuv};
    for(int i=0;i<2;i++){images[i].format=0x802;images[i].width=640;images[i].height=480;
        images[i].planes[0]=data[i];images[i].planes[1]=data[i]+pixels;images[i].pitches[0]=640;images[i].pitches[1]=640;}
    DepthParam p={90,0,NULL,NULL,0,0};
    printf("{\"event\":\"before_depth\",\"wrapper_state_1e4\":%d,\"capture_mode\":%d,\"focus_raw\":%d}\n",
           i32(h,0x1e4),i32(h,0x8868),i32(h,0x881c));
    rc=calc(h,&images[0],&images[1],&p);printf("{\"event\":\"calc_disparity\",\"rc\":%d,\"depth_validated\":false}\n",rc);
    printf("{\"event\":\"after_depth\",\"wrapper_state_1e4\":%d,\"solution_raw\":%d}\n",i32(h,0x1e4),i32(h,0x88a4));
    if(rc)goto finish;
    Offscreen output={0};rc=get(h,&output);printf("{\"event\":\"get_disparity\",\"rc\":%d,\"format\":%u,\"width\":%d,\"height\":%d,\"pitch\":%d}\n",rc,output.format,output.width,output.height,output.pitches[0]);
    if(rc||output.format!=0x701||output.width<1||output.height<1||output.width>4096||output.height>4096||output.pitches[0]<output.width||output.pitches[0]>16384||!readable(output.planes[0],(size_t)output.height*output.pitches[0]))goto finish;
    FILE *f=fopen(argv[4],"wbx");if(!f)goto finish;
    fprintf(f,"P5\n%d %d\n255\n",output.width,output.height);int ok=1;
    for(int y=0;y<output.height;y++)if(fwrite((unsigned char *)output.planes[0]+(size_t)y*output.pitches[0],1,output.width,f)!=(size_t)output.width)ok=0;
    if(fclose(f))ok=0;status=ok?0:1;
finish:
    if(h){rc=uninit(&h);printf("{\"event\":\"uninit\",\"rc\":%d,\"released\":%s}\n",rc,h?"false":"true");if(rc||h)status=1;}
    dlclose(lib);free(main_yuv);free(aux_yuv);return status;
}
