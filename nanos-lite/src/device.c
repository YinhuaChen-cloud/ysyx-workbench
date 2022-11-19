#include <common.h>

#if defined(MULTIPROGRAM) && !defined(TIME_SHARING)
# define MULTIPROGRAM_YIELD() yield()
#else
# define MULTIPROGRAM_YIELD()
#endif

#define NAME(key) \
  [AM_KEY_##key] = #key,

static const char *keyname[256] __attribute__((used)) = {
  [AM_KEY_NONE] = "NONE",
  AM_KEYS(NAME)
};

size_t serial_write(const void *buf, size_t offset, size_t len) {
	int count;
	char *p = (char *)buf;
	for(count = 0; count < len && *p != '\0'; count++) {
		putch(*p);
		p++;
	}
  return p - (char *)buf;
}

size_t events_read(void *buf, size_t offset, size_t len) {
//	printf("len = %d\n");

	AM_INPUT_KEYBRD_T ev = io_read(AM_INPUT_KEYBRD);

	if (ev.keycode == AM_KEY_NONE) return 0;

	size_t retval = snprintf(buf, len, "%s %s\n", ev.keydown ? "kd" : "ku", keyname[ev.keycode]);

//	printf("retval = %d\n", retval);

	return retval;
}

extern int screen_width;
extern int screen_height;

size_t dispinfo_read(void *buf, size_t offset, size_t len) {
//	一个合法的 `/proc/dispinfo`文件例子如下: 
//	WIDTH : 640
//	HEIGHT:480
	size_t retval = snprintf(buf, len, "WIDTH\t: %d\nHEIGHT\t: %d\n", screen_width, screen_height);
  return retval;
}

size_t fb_write(const void *buf, size_t offset, size_t len) {
	assert(offset + len <= screen_width * screen_height * sizeof(uint32_t));
	// TODO: 我们可以一次画一行，而不是一个一个点去画，等有了评测函数性能的方法再改进 
	for(int i = 0; i < len; i++) {
		int x = (offset + i) % screen_width;
		int y = (offset + i) / screen_width;
		io_write(AM_GPU_FBDRAW, x, y, (uint8_t *)buf + i, 1, 1, false);
	}
  io_write(AM_GPU_FBDRAW, 0, 0, NULL, 0, 0, true);
	return len;
}

void init_device() {
  Log("Initializing devices...");
  ioe_init();
}
