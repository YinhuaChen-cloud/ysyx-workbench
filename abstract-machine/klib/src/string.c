#include <klib.h>
#include <klib-macros.h>
#include <stdint.h>

#if !defined(__ISA_NATIVE__) || defined(__NATIVE_USE_KLIB__)

size_t strlen(const char *s) {  
  const char *p = s;
  while(*p) p++;
  return p - s;
}

char *strcpy(char *dst, const char *src) {
  int i = 0;
  int k = 0;
  while(src[k] != '\0') {
    dst[i] = src[k];
    i++;
    k++;
  }
  dst[i] = src[k];
  return dst;
}

char *strncpy(char *dst, const char *src, size_t n) {
  panic("Not implemented");
}

char *strcat(char *dst, const char *src) {
  int i = 0;
  int k = 0;
  while(dst[i] != '\0') i++;
  while(src[k] != '\0') {
    dst[i] = src[k];
    i++;
    k++;
  }
  dst[i] = src[k];
  return dst;
}

int strcmp(const char *s1, const char *s2) {
  int i = 0;
  while(s1[i] != '\0' && s2[i] != '\0') {
    if(s1[i] != s2[i])
      return s1[i] - s2[i];
    i++;
  }
  return s1[i] - s2[i];
}

int strncmp(const char *s1, const char *s2, size_t n) {
  panic("Not implemented");
}

void *memset(void *s, int c, size_t n) {
  char *p = s;
  while(n) {
    *p = c;
    p++;
    n--;
  }
  return s;
}

void *memmove(void *dst, const void *src, size_t n) {
  panic("Not implemented");
}

// We do not care about memory overlap now 
void *memcpy(void *out, const void *in, size_t n) {
	const char *pin = (const char *)in;
	char *pout = (char *)out;
  while(n) {
		*pout = *pin;
		pout++;
		pin++;
    n--;
  }
  return out;
}

int memcmp(const void *s1, const void *s2, size_t n) {
  const char *p = s1;
  const char *q = s2;
  while(n) {
    if(*p != *q)
      return *p - *q;
		p++;
		q++;
    n--;
  }
  return 0;
}

#endif
