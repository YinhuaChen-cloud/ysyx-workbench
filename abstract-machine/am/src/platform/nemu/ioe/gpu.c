#include <am.h>
#include <nemu.h>

#define SYNC_ADDR (VGACTL_ADDR + 4)

void __am_gpu_init() {
}

//FB_ADDR
void __am_gpu_config(AM_GPU_CONFIG_T *cfg) {
	uint32_t gpu_config = inl(VGACTL_ADDR);
  *cfg = (AM_GPU_CONFIG_T) {
    .present = true, .has_accel = false,
    .width = gpu_config >> 16, .height = gpu_config & 0xFFFF,
    .vmemsz = (gpu_config >> 16) * (gpu_config & 0xFFFF) * sizeof(uint32_t)
  };
}

void __am_gpu_fbdraw(AM_GPU_FBDRAW_T *ctl) {
	// draw it
	uint32_t *fb = (uint32_t *)(uintptr_t)FB_ADDR;	
	AM_GPU_CONFIG_T cfg;
	__am_gpu_config(&cfg);
//	int draw_block_szie = ctl->w * ctl->h;
	int k = 0 ;
//	fb[ctl->y*cfg.width + ctl->x] this is the start point
	for(int i = 0; i < ctl->h; i++) {
		for(int j = 0; j < ctl->w; j++) {
			fb[(i + ctl->y)*cfg.width + ctl->x + j] = ((uint32_t *)(ctl->pixels))[k];
			k++;
		}
	}
	// sync it
  if (ctl->sync) {
    outl(SYNC_ADDR, 1);
  }
}

void __am_gpu_status(AM_GPU_STATUS_T *status) {
  status->ready = true;
}
