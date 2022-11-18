#include <fs.h>

typedef size_t (*ReadFn) (void *buf, size_t offset, size_t len);
typedef size_t (*WriteFn) (const void *buf, size_t offset, size_t len);

typedef struct {
  char *name;
  size_t size;
  size_t disk_offset;
  ReadFn read;
  WriteFn write;
// 另外, 我们也不希望每次读写操作都需要从头开始. 于是我们需要为每一个已经打开的文件引入偏移量属性open_offset, 来记录目前文件操作的位置. 每次对文件读写了多少个字节, 偏移量就前进多少.
// 由于Nanos-lite是一个精简版的操作系统, 上述问题暂时不会出现, 为了简化实现, 我们还是把偏移量放在文件记录表中进行维护
	size_t open_offset;
} Finfo;

enum {FD_STDIN, FD_STDOUT, FD_STDERR, FD_FB};

size_t invalid_read(void *buf, size_t offset, size_t len) {
  panic("should not reach here");
  return 0;
}

size_t invalid_write(const void *buf, size_t offset, size_t len) {
  panic("should not reach here");
  return 0;
}

/* This is the information about all files in disk. */
// This function attribute informs the compiler that a static function is to be retained in the object file, even if it is unreferenced. Functions marked with __attribute__((used)) are tagged in the object file to avoid removal by linker unused section removal.
static Finfo file_table[] __attribute__((used)) = {
  [FD_STDIN]  = {"stdin", 0, 0, invalid_read, invalid_write},
  [FD_STDOUT] = {"stdout", 0, 0, invalid_read, invalid_write},
  [FD_STDERR] = {"stderr", 0, 0, invalid_read, invalid_write},
#include "files.h"
};

void init_fs() {
  // TODO: initialize the size of /dev/fb
}

int fs_open(const char *pathname, int flags, int mode) { // -- checked
//	2. 为了简化实现, 我们允许所有用户程序都可以对所有已存在的文件进行读写, 这样以后, 我们在实现fs_open()的时候就可以忽略flags和mode了.
	int i = 0;
	for(; i < sizeof(file_table)/sizeof(file_table[0]); i++) {
		if(strcmp(pathname, file_table[i].name) == 0)
			break;
	}
//	1. 由于sfs中每一个文件都是固定的, 不会产生新文件, 因此"fs_open()没有找到pathname所指示的文件"属于异常情况, 你需要使用assertion终止程序运行.
	assert(i < sizeof(file_table)/sizeof(file_table[0]));
	file_table[i].open_offset = 0;
	return i;
}

size_t fs_read(int fd, void *buf, size_t len) {
//5. 除了写入stdout和stderr之外(用putch()输出到串口), 其余对于stdin, stdout和stderr这三个特殊文件的操作可以直接忽略.
	if(fd <= 2)
		return 0;
//4. 由于文件的大小是固定的, 在实现fs_read(), fs_write()和fs_lseek()的时候, 注意偏移量不要越过文件的边界.
	if(len > file_table[fd].size - file_table[fd].open_offset) {
		len = file_table[fd].size - file_table[fd].open_offset;
	}
//3. 使用ramdisk_read()和ramdisk_write()来进行文件的真正读写.
	extern size_t ramdisk_read(void *buf, size_t offset, size_t len);
	size_t retval = ramdisk_read(buf, file_table[fd].disk_offset + file_table[fd].open_offset, len);

	file_table[fd].open_offset += retval;
	
	assert(file_table[fd].open_offset <= file_table[fd].size);	
	return retval;
}

size_t fs_write(int fd, const void *buf, size_t len) {
//5. 除了写入stdout和stderr之外(用putch()输出到串口), 其余对于stdin, stdout和stderr这三个特殊文件的操作可以直接忽略.
	if(fd == FD_STDIN)	
		return 0;
	assert(fd > 2);
//4. 由于文件的大小是固定的, 在实现fs_read(), fs_write()和fs_lseek()的时候, 注意偏移量不要越过文件的边界.
	if(len > file_table[fd].size - file_table[fd].open_offset) {
		len = file_table[fd].size - file_table[fd].open_offset;
		assert(0);
	}
//3. 使用ramdisk_read()和ramdisk_write()来进行文件的真正读写.
	extern size_t ramdisk_write(const void *buf, size_t offset, size_t len);
	size_t retval = ramdisk_write(buf, file_table[fd].open_offset, len);

	file_table[fd].open_offset += retval;
	
	assert(file_table[fd].open_offset <= file_table[fd].size);	
	return retval;
}

size_t fs_lseek(int fd, size_t offset, int whence) {
	int base;
	
	assert(whence == SEEK_SET || whence == SEEK_CUR || whence == SEEK_END);
	if(SEEK_SET == whence) {
		base = 0;
	}
	else if(SEEK_CUR == whence) {
		base = file_table[fd].open_offset;
	}
	else {
		base = file_table[fd].size;
	}
//4. 由于文件的大小是固定的, 在实现fs_read(), fs_write()和fs_lseek()的时候, 注意偏移量不要越过文件的边界.
	assert(base + offset >= 0 && base + offset <= file_table[fd].size);
	file_table[fd].open_offset = base + offset;
	return file_table[fd].open_offset;
}

// 6. 由于sfs没有维护文件打开的状态, fs_close()可以直接返回0, 表示总是关闭成功.
int fs_close(int fd) {
	return 0;
}

