#define SDL_malloc  malloc
#define SDL_free    free
#define SDL_realloc realloc

#define SDL_STBIMAGE_IMPLEMENTATION
#include "SDL_stbimage.h"
#include <stdio.h>

SDL_Surface* IMG_Load_RW(SDL_RWops *src, int freesrc) {
  assert(src->type == RW_TYPE_MEM);
  assert(freesrc == 0);
  return NULL;
}

SDL_Surface* IMG_Load(const char *filename) {
	printf("omg, filename = %s\n", filename);
	// 1. 用libc中的文件操作打开文件, 并获取文件大小size
	FILE *fp = fopen(filename, "r");
	fseek(fp, 0, SEEK_END);
	printf("execute fseek successfully\n");
	size_t filesize = ftell(fp);
	// 2. 申请一段大小为size的内存区间buf
	uint8_t *buf = (uint8_t *)malloc(sizeof(filesize));
	printf("execute malloc successfully\n");
	// 3. 将整个文件读取到buf中
	fseek(fp, 0, SEEK_SET);
	fread(buf, filesize, 1, fp);
	printf("execute fread successfully\n");
	// 4. 将buf和size作为参数, 调用STBIMG_LoadFromMemory(), 它会返回一个SDL_Surface结构的指针
	SDL_Surface *s = STBIMG_LoadFromMemory(buf, filesize);	
	printf("execute STBIMGLOAD successfully\n");
	// 5. 关闭文件, 释放申请的内存
	fclose(fp);
	free(buf);
	buf = NULL;
	// 6. 返回SDL_Surface结构指针
  return s;
}

int IMG_isPNG(SDL_RWops *src) {
  return 0;
}

SDL_Surface* IMG_LoadJPG_RW(SDL_RWops *src) {
  return IMG_Load_RW(src, 0);
}

char *IMG_GetError() {
  return "Navy does not support IMG_GetError()";
}
