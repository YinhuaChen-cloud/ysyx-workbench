#include <am.h>
#include <klib.h>
#include <klib-macros.h>
#include <stdarg.h>
#include <stdbool.h>

#if !defined(__ISA_NATIVE__) || defined(__NATIVE_USE_KLIB__)

#define PRINT_BUF_LEN 1024
char printf_buf[PRINT_BUF_LEN];

int printf(const char *fmt, ...) {
	int num_p = -1;
	va_list args;
	va_start(args, fmt);
	num_p = vsprintf(printf_buf, fmt, args);
	va_end(args);
	putstr(printf_buf);
	return num_p;
}

int itoa(char *pout, int val);
int itox(char *pout, int val);
int u64tox(char *pout, uint64_t val);
int u64toa(char *pout, uint64_t val);

int vsprintf(char *out, const char *fmt, va_list ap) {
  char *pout = out;
  const char *pfmt = fmt;
  bool flag = false;
	bool longflag = false;

  char *sval;
  int ival;
	uint64_t longval;

  int tmp;

  while(*pfmt != '\0') {
    if(*pfmt != '%' && !flag) {
      *pout = *pfmt;
      pout++;
      pfmt++;
    }
    else if(*pfmt == '%' && !flag) {
      flag = true;
      pfmt++;
    }
    else if(flag) {
      switch (*pfmt) {
        case 'd':
					if(longflag) {
						longflag = false;
						longval = va_arg(ap, uint64_t);
						tmp = u64toa(pout, longval);
						pout += tmp;
					}
					else {
						// print number
						ival = va_arg(ap, int);
						tmp = itoa(pout, ival);
						pout += tmp;
						flag = false;
					}
          break;
        case 's':
					if(longflag)
						assert(0);
          // print string
          sval = va_arg(ap, char *);
					assert(sval);
          strcpy(pout, sval);
          pout += strlen(sval);
					flag = false;
          break;
        case '%':
					if(longflag)
						assert(0);
          // print %
          *pout =  '%';
          pout++;
					flag = false;
          break;
				case 'x': 
					if(longflag) {
						longflag = false;
						longval = va_arg(ap, uint64_t);
						tmp = u64tox(pout, longval);
						pout += tmp;
					}
					else {
						// print hex number
						ival = va_arg(ap, int);
						tmp = itox(pout, ival);
						pout += tmp;
						flag = false;
					}
          break;
				case 'l':
					longflag = true;
					break;
        default:
					if(*pfmt >= '0' && *pfmt <= '9') {
						// 1. this is width: 1.1 not zero  1.2. zero, but only this one number
						// 2. this is 0-complement: 2.1. zero, and there is non-zero behind
						// TODO: maybe we can just skip all these things since it does not affect
						// test cases' execution
					} else {
						// this assert here will cause some unexpected error in NEMU-NEMU model
						// comment it out if u want to run NEMU-NEMU model
//						assert(0);
					}
      }
      pfmt++;
    }
    else {
      assert(0);
    }
  }
  *pout = '\0';
  return pout - out;
}

int sprintf(char *out, const char *fmt, ...) {
	int num_p = -1;
	va_list args;
	va_start(args, fmt);
	num_p = vsprintf(out, fmt, args);
	va_end(args);
	return num_p;
}

int snprintf(char *out, size_t n, const char *fmt, ...) {
  panic("Not implemented");
}

int vsnprintf(char *out, size_t n, const char *fmt, va_list ap) {
  panic("Not implemented");
}

int u64tox(char *pout, uint64_t val) {
	int front, end;
	front = (int)(val >> 32); 
	int tmp = itox(pout, front);
	pout += tmp;
	end = (int)(val & 0xffffffff); 
	tmp += itox(pout, end);
	return tmp;
}

// convert val to hex string in pout, return the number of char printed
int itox(char *pout, int val) {
#define HEX_CHAR_NR 16
	const char dec_to_hex[HEX_CHAR_NR] = {'0', '1', '2', '3', '4', '5', '6', \
		'7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
  char *p = pout;
  int digit = 0;
  int division;
  if(!val) {
    *p = '0';
    return 1;
  }

  int tmp = val; 
  while(tmp) {
    digit++; 
    tmp /= HEX_CHAR_NR;
  }

	division = 1;
	for(int i = 0; i < digit-1; i++){
		division *= HEX_CHAR_NR;
	}

  while(division) {  // division = 1
    *p = dec_to_hex[((val/division) % HEX_CHAR_NR)]; // 
    p++;
    division /= HEX_CHAR_NR;
  }
#undef HEX_CHAR_NR 
  return p - pout;
}

int u64toa(char *pout, uint64_t val) {
	return 0;
}

// convert val to string in pout, return the number of char printed
int itoa(char *pout, int val) {
  char *p = pout;
  int digit = 0;
  int division;
  if(!val) {
    *p = '0';
    return 1;
  }

  int tmp = val; 
  while(tmp) {
    digit++; 
    tmp /= 10;
  }

	division = 1;
	for(int i = 0; i < digit-1; i++){
		division *= 10;
	}

  while(division) {  // division = 1
    *p = ((val/division) % 10) + '0'; // 
    p++;
    division /= 10;
  }
  
  return p - pout;
}

#endif
