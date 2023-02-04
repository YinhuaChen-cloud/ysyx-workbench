#ifndef __SDB_H__
#define __SDB_H__

#include <stdint.h>

extern uint64_t pc_just_exec;

void sdb_mainloop();
void init_sdb();

#endif
