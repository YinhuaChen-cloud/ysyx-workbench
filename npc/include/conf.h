#ifndef __CONF_H__
#define __CONF_H__

// configuration about npc
//#define CONFIG_MSIZE 0x2000000 //
#define CONFIG_MBASE 0x80000000
#define CONFIG_PC_RESET_OFFSET 0x0

// configuration about peripheral
#define CONFIG_DEVICE_BASE 0xa0000000

#define CONFIG_MMIO_BASE 0xa0000000

#define CONFIG_SERIAL_PORT     (CONFIG_DEVICE_BASE + 0x00003f8)
#define CONFIG_KBD_ADDR        (CONFIG_DEVICE_BASE + 0x0000060)
#define CONFIG_RTC_ADDR        (CONFIG_DEVICE_BASE + 0x0000048)
#define CONFIG_VGACTL_ADDR     (CONFIG_DEVICE_BASE + 0x0000100)
#define CONFIG_AUDIO_ADDR      (CONFIG_DEVICE_BASE + 0x0000200)
#define CONFIG_DISK_ADDR       (CONFIG_DEVICE_BASE + 0x0000300)
#define CONFIG_FB_ADDR         (CONFIG_MMIO_BASE   + 0x1000000)
#define CONFIG_AUDIO_SBUF_ADDR (CONFIG_MMIO_BASE   + 0x1200000)

#endif
