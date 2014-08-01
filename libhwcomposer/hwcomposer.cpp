/*
 * Copyright (C) 2010 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <hardware/hardware.h>

#include <fcntl.h>
#include <errno.h>

#include <cutils/log.h>
#include <cutils/atomic.h>

#include <hardware/hwcomposer.h>

#include <EGL/egl.h>

#ifdef BCM_HARDWARE
#include <cstring>
#include "ghw_composer.h"
#include "gralloc_priv.h"
#define EGL_EGLEXT_PROTOTYPES
#include <EGL/eglext.h>
#include <GLES/gl.h>
#endif

/*****************************************************************************/

#ifdef BCM_HARDWARE
namespace ghw{

class GhwMemHandle_Wrap : public GhwMemHandle {
public:
    u32        mPhys;
    void*      mVirt;
    u32        mSize;
    u32        refcnt;
    GhwMemHandle_Wrap(u32 phys,void* virt,u32 size):mPhys(phys),mVirt(virt),mSize(size),refcnt(1) {};

    virtual    ghw_error_e     acquire(){refcnt++; return GHW_ERROR_NONE;};
    virtual    ghw_error_e     release(){refcnt--; if(refcnt==0) delete this;return GHW_ERROR_NONE;};
    virtual    ghw_error_e     lock(u32& ipa_addr, void*& virt_addr, u32& size){ipa_addr = mPhys; virt_addr = mVirt; size = mSize;return GHW_ERROR_NONE;};
    virtual    ghw_error_e     unlock(){return GHW_ERROR_NONE;};
    virtual    ghw_error_e     setName(const char *name){return GHW_ERROR_NONE;};
    virtual    ghw_error_e     dump(u32 level = 0){return GHW_ERROR_NONE;};
    virtual    ~GhwMemHandle_Wrap(){};
};

};
using namespace ghw;
#endif

struct hwc_context_t {
    hwc_composer_device_1_t device;
    /* our private state goes below here */
#ifdef BCM_HARDWARE
    pthread_t vsync_thread;
    GhwComposer* local_composer;
    GhwComposer* egl_composer;
    bool useComposer;
    unsigned int ucount;
    unsigned int logtime;
#endif
};

static int hwc_device_open(const struct hw_module_t* module, const char* name,
        struct hw_device_t** device);

static struct hw_module_methods_t hwc_module_methods = {
    open: hwc_device_open
};

hwc_module_t HAL_MODULE_INFO_SYM = {
    common: {
        tag: HARDWARE_MODULE_TAG,
        version_major: 1,
        version_minor: 0,
        id: HWC_HARDWARE_MODULE_ID,
        name: "Sample hwcomposer module",
        author: "The Android Open Source Project",
        methods: &hwc_module_methods,
    }
};

/*****************************************************************************/

#ifdef BCM_HARDWARE
static void *hwc_vsync_thread(void *data)
{
    return NULL;
}

static int hwc_create_vsync_thread(struct hwc_context_t *dev)
{
    ALOGD("%s:%d creating vsync thread", __FUNCTION__,__LINE__);
    int return_value = pthread_create(&dev->vsync_thread, NULL, hwc_vsync_thread, dev);
    if (return_value) {
    ALOGE("%s:%d failed to start vsync thread: %s", __FUNCTION__,__LINE__ ,strerror(return_value));
        return_value = -return_value;
    }
    return return_value;
}
#endif

static void dump_layer(hwc_layer_1_t const* l) {
    ALOGD("\ttype=%d, flags=%08x, handle=%p, tr=%02x, blend=%04x, {%d,%d,%d,%d}, {%d,%d,%d,%d}",
            l->compositionType, l->flags, l->handle, l->transform, l->blending,
            l->sourceCrop.left,
            l->sourceCrop.top,
            l->sourceCrop.right,
            l->sourceCrop.bottom,
            l->displayFrame.left,
            l->displayFrame.top,
            l->displayFrame.right,
            l->displayFrame.bottom);
}

static int hwc_prepare(hwc_composer_device_1_t *dev,
        size_t numDisplays, hwc_display_contents_1_t** displays) {
#ifdef BCM_HARDWARE
    struct hwc_context_t* ctx = (struct hwc_context_t*)dev;
#endif
    if (displays && (displays[0]->flags & HWC_GEOMETRY_CHANGED)) {
#ifdef BCM_HARDWARE
        // Default Settings for composer is to use composer
        // Hence Set useComposer to true
        // Also, Set the composition type to OVERLAY so that Surfaceflinger does not compose these layers
        ctx->useComposer = true;
        int compType= HWC_OVERLAY;
#endif
        for (size_t i=0 ; i<displays[0]->numHwLayers ; i++) {
#ifndef BCM_HARDWARE
            //dump_layer(&list->hwLayers[i]);
            displays[0]->hwLayers[i].compositionType = HWC_FRAMEBUFFER;
#else
            if(displays[0]->hwLayers[i].flags & HWC_SKIP_LAYER) {
                // Surfaceflinger signalled that HW Composer should not compose this layer
                // Current design is not capable of drawing some layers using OpenGL and some layers using HW Composer since
                // the Order of the requests to HW will be lost.
                // Hence, when this signal is given, Force Surfaceflinger to composer all layers
                ctx->useComposer = false;
                compType = HWC_FRAMEBUFFER;
            }
            for (size_t i=0 ; i<displays[0]->numHwLayers ; i++) {
                displays[0]->hwLayers[i].compositionType = compType;
            }
#endif
        }
    }
    return 0;
}

#ifdef BCM_HARDWARE
static int get_lib_format(const int& in, u32& format, u32& intformat)
{
    // Foy YUV layers , default output format after conversion is RGB565
    // Change intformat also change the memory allocations and stride parameters in GRALLOC appropriately
    switch(in)
        {
        case HAL_PIXEL_FORMAT_RGBA_8888:
            format = GHW_PIXEL_FORMAT_RGBA_8888;
            intformat = format;
            break;
        case HAL_PIXEL_FORMAT_RGBX_8888:
            format = GHW_PIXEL_FORMAT_RGBX_8888;
            intformat = format;
            break;
        case HAL_PIXEL_FORMAT_RGB_888:
            format = GHW_PIXEL_FORMAT_RGB_888;
            intformat = format;
            break;
        case HAL_PIXEL_FORMAT_RGB_565:
            format = GHW_PIXEL_FORMAT_RGB_565;
            intformat = format;
            break;
        case HAL_PIXEL_FORMAT_BGRA_8888:
            format = GHW_PIXEL_FORMAT_BGRA_8888;
            intformat = format;
            break;
        case HAL_PIXEL_FORMAT_RGBA_5551:
            format = GHW_PIXEL_FORMAT_RGBA_5551;
            intformat = format;
            break;
        case HAL_PIXEL_FORMAT_RGBA_4444:
            format = GHW_PIXEL_FORMAT_RGBA_4444;
            intformat = format;
            break;
        case HAL_PIXEL_FORMAT_YCrCb_420_SP:
            format = GHW_PIXEL_FORMAT_YCrCb_420_SP;
            intformat = GHW_PIXEL_FORMAT_RGB_565;
            break;
        case HAL_PIXEL_FORMAT_YCbCr_420_SP:
            format = GHW_PIXEL_FORMAT_YCbCr_420_SP;
            intformat = GHW_PIXEL_FORMAT_RGB_565;
            break;
        case HAL_PIXEL_FORMAT_YV12:
            format = GHW_PIXEL_FORMAT_YCbCr_420_P;
            intformat = GHW_PIXEL_FORMAT_RGB_565;
            break;
        case HAL_PIXEL_FORMAT_YCbCr_420_P:
            format = GHW_PIXEL_FORMAT_YCbCr_420_P;
            intformat = GHW_PIXEL_FORMAT_RGB_565;
            break;
        default:
            ALOGE("Unsupported format %d",in);
            return -1;
        }
    return 0;
}
#endif

static int hwc_set(hwc_composer_device_1_t *dev,
        size_t numDisplays, hwc_display_contents_1_t** displays)
{
    //for (size_t i=0 ; i<list->numHwLayers ; i++) {
    //    dump_layer(&list->hwLayers[i]);
    //}

#ifdef BCM_HARDWARE
    struct hwc_context_t* ctx = (struct hwc_context_t*)dev;
    u32 format = 0,intformat =0;
    GhwComposer* composer;

    // glEGLImageTargetTexture2DOES extension in BroadCom OpenGL library performs the tRSO to Tile Format conversion
    // glGetTextureStorage is implemented in V3D OpenGL stack to retrieve the Texture physical address (in Tile Format)
    // If Software OpenGL is used, the OpenGL extension might not be implemented or does not perform Tile Conversion
    // In Such cases, Tile Conversion is performed here

    const GLubyte* vendor = glGetString(GL_VENDOR);

    bool convert = (0 != strcmp((const char*)vendor , "Broadcom"));

    void* tempptr = eglGetRenderBufferANDROID((EGLDisplay)displays[0]->dpy, (EGLSurface)displays[0]->sur);
    ctx->egl_composer = (GhwComposer*)eglGetComposerANDROID((EGLDisplay)displays[0]->dpy, (EGLSurface)displays[0]->sur);

    if (ctx->egl_composer) {
        composer = ctx->egl_composer;
        if (ctx->local_composer) {
            delete ctx->local_composer;
            ctx->local_composer = NULL;
        }
    } else {
        if (ctx->local_composer == NULL) {
            ctx->local_composer = GhwComposer::create();
        }
        composer = ctx->local_composer;
    }

    const private_handle_t* fbhandle = reinterpret_cast <const private_handle_t*> (tempptr);

    if(fbhandle == NULL){
        ALOGE("fbhandle is NULL");
        return 0;
    }
    GhwMemHandle* fbwrap = new GhwMemHandle_Wrap(fbhandle->p_addr + fbhandle->offset,(void*)(fbhandle->base),fbhandle->size);
    GhwImgBuf* img = GhwImgBuf::create();
    GhwImgBuf* intimg = GhwImgBuf::create();
    GhwImgOp* op = GhwImgOp::create();

    if( ctx->useComposer && displays) {
        img->setMemHandle(fbwrap);
        img->setGeometry(fbhandle->alignedw,fbhandle->alignedh);
        get_lib_format(fbhandle->format,format,intformat);
        img->setFormat(format);
        img->setCrop(fbhandle->w,fbhandle->h);

        composer->compSetFb(img,GHW_DITHER_NONE);

        for (size_t i=0 ; i<displays[0]->numHwLayers ; i++) {
            const private_handle_t* handle = reinterpret_cast <const private_handle_t*>(displays[0]->hwLayers[i].handle);
            if(handle == NULL) {
                continue;
            }
            if(get_lib_format(handle->format,format,intformat)) {
                ALOGE("Skipping layer draw with unknown format %d",handle->format);
                continue;
            }
            GhwMemHandle* wrap = new GhwMemHandle_Wrap(handle->p_addr,(void*)(handle->base),handle->size/2);
            img->setMemHandle(wrap);
            img->setGeometry(handle->alignedw,handle->alignedh);
            img->setFormat(format);
            img->setCrop(handle->w,handle->h);

            GhwMemHandle* intwrap =  new GhwMemHandle_Wrap((u32)(handle->p_addr + (handle->size/2)),(void*)(handle->base+(handle->size/2)),handle->size/2);
            intimg->setMemHandle(intwrap);
            intimg->setGeometry(handle->alignedw,handle->alignedh);
            intimg->setFormat(intformat,GHW_MEM_LAYOUT_TILED);
            intimg->setCrop(handle->w,handle->h);

            op->setDstWindow(0,0,handle->w,handle->h);
            op->setTransform(0);

            if(convert) composer->imgProcess(img,intimg,op,0);

            hwc_rect_t* rect = &displays[0]->hwLayers[i].sourceCrop;
            intimg->setCrop(rect->left,rect->top,rect->right,rect->bottom);

            rect = &displays[0]->hwLayers[i].displayFrame;
            op->setDstWindow(rect->left,rect->top,rect->right,rect->bottom);
            op->setTransform(displays[0]->hwLayers[i].transform);

            composer->compDrawRect(intimg,op);
            wrap->release();
            intwrap->release();
        }

        composer->compCommit(0);
        composer->barrier();

    } else {
        glFlush();

        if((fbhandle->format == HAL_PIXEL_FORMAT_BGRA_8888) && !convert) {
            img->setMemHandle(fbwrap);
            img->setGeometry(fbhandle->alignedw,fbhandle->alignedh);
            get_lib_format(HAL_PIXEL_FORMAT_RGBA_8888,format,intformat);
            img->setFormat(format);
            img->setCrop(fbhandle->w,fbhandle->h);

            intimg->setMemHandle(fbwrap);
            intimg->setGeometry(fbhandle->alignedw,fbhandle->alignedh);
            get_lib_format(fbhandle->format,format,intformat);
            intimg->setFormat(format);
            intimg->setCrop(fbhandle->w,fbhandle->h);

            op->setDstWindow(0,0,fbhandle->alignedw,fbhandle->alignedh);
            op->setTransform(0);

            composer->imgProcess(img,intimg,op,0);
        }
        composer->barrier();
    }

    fbwrap->release();
    delete img;
    delete intimg;
    delete op;

    struct timeval t1;
    gettimeofday(&t1,NULL);

    if(t1.tv_sec == ctx->logtime) {
        ctx->ucount++;
    } else {
        ALOGV("FrameBuffer [%d] reloads", ctx->ucount);
        ctx->ucount = 1;
        ctx->logtime = t1.tv_sec;
    }
#endif

    EGLBoolean sucess = eglSwapBuffers((EGLDisplay)displays[0]->dpy,
            (EGLSurface)displays[0]->sur);
    if (!sucess) {
        return HWC_EGL_ERROR;
    }
    return 0;
}

static int hwc_device_close(struct hw_device_t *dev)
{
    struct hwc_context_t* ctx = (struct hwc_context_t*)dev;
    if (ctx) {
#ifdef BCM_HARDWARE
        delete ctx->local_composer;
        ctx->local_composer = NULL;
        ctx->egl_composer = NULL;

        pthread_kill(ctx->vsync_thread, SIGTERM);
        pthread_join(ctx->vsync_thread, NULL);
#endif
        free(ctx);
    }
    return 0;
}

#ifdef BCM_HARDWARE
static int hwc_event_control(struct hwc_composer_device_1 *device, int dpy,int event, int enabled)
{
    struct hwc_context_t* dev = (struct hwc_context_t*)device;
    ALOGV("%s:%d event=%d enabled=%d", __FUNCTION__,__LINE__,event,enabled);
    int return_value = -EINVAL ;
    switch (event) {
    case HWC_EVENT_VSYNC:
        return_value = 0 ;
    }
    ALOGV("%s:%d return_value=%d", __FUNCTION__,__LINE__,return_value);
    return return_value;
}

// toggle display on or off
static int hwc_blank(struct hwc_composer_device_1* device, int disp, int blank)
{
    // dummy implementation for now
    ALOGD("%s:%d disp=%d blank=%d", __FUNCTION__,__LINE__,disp,blank);
    return 0;
}

static int hwc_query(struct hwc_composer_device_1* device,int param, int* value)
{
    // dummy implementation for now
    ALOGD("%s:%d param=%d value=%p", __FUNCTION__,__LINE__,param,value);
    int return_value = 0 ; 
    switch(param){
	case   HWC_DISPLAY_TYPES_SUPPORTED:
	    value[0] = HWC_DISPLAY_PRIMARY_BIT;
	    break;
	case  HWC_BACKGROUND_LAYER_SUPPORTED:
	    value[0] = 0;
	    break;
	default:
	    return_value = -1; 
	}
	return return_value;
}

static void hwc_dump(hwc_composer_device_1* device, char *buff, int buff_len)
{
    // dummy implementation for now
    ALOGD("%s:%d buff=%s buff_len=%d", __FUNCTION__,__LINE__,buff,buff_len);
}
#endif

/*****************************************************************************/

static int hwc_device_open(const struct hw_module_t* module, const char* name,
        struct hw_device_t** device)
{
    int status = -EINVAL;
#ifdef BCM_HARDWARE
    ALOGD("%s",__FUNCTION__);
#endif
    if (!strcmp(name, HWC_HARDWARE_COMPOSER)) {
        struct hwc_context_t *dev;
        dev = (hwc_context_t*)malloc(sizeof(*dev));

        /* initialize our state here */
        memset(dev, 0, sizeof(*dev));

        /* initialize the procs */
        dev->device.common.tag = HARDWARE_DEVICE_TAG;
        dev->device.common.version = HWC_DEVICE_API_VERSION_1_0;
        dev->device.common.module = const_cast<hw_module_t*>(module);
        dev->device.common.close = hwc_device_close;

        dev->device.prepare = hwc_prepare;
        dev->device.set = hwc_set;

#ifdef BCM_HARDWARE
        dev->device.eventControl = hwc_event_control;
        dev->device.blank = hwc_blank;
        dev->device.query = hwc_query;
        dev->device.dump = hwc_dump;

        dev->local_composer = GhwComposer::create();
        dev->useComposer = true;

        dev->logtime =0;
        dev->ucount =0;
#endif

        *device = &dev->device.common;

#ifdef BCM_HARDWARE
        // setup a vsync worker thread
        hwc_create_vsync_thread(dev);
#endif

        status = 0;
    }
    return status;
}
