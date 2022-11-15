#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

int main(int argc, char *argv[], char *envp[]); // TODO: how do main correlate to user program?
extern char **environ;
void call_main(uintptr_t *args) {
  char *empty[] =  {NULL };
  environ = empty;
	printf("in call_main\n");
  exit(main(0, empty, empty));
  assert(0);
}
