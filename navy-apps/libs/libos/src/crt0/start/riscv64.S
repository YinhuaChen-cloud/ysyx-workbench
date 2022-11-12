.globl  _start
_start:
  move s0, zero
  jal call_main

# 用户程序的入口位于navy-apps/libs/libos/src/crt0/start/$ISA.S中的_start()函数
# 
# 这里的crt是C RunTime的缩写, 0的含义表示最开始.
# 
# _start()函数会调用navy-apps/libs/libos/src/crt0/crt0.c中的call_main()函数, 
# 然后调用用户程序的main()函数, 从main()函数返回后会调用exit()结束运行.
