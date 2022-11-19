#include <NDL.h>
#include <stdio.h>

int main() {
	NDL_Init(0);

	uint32_t curtime = NDL_GetTicks();
	uint32_t prevtime = curtime;
	while(1) {
		// = has a lower priority than &&
		while((curtime = NDL_GetTicks()) && (curtime - prevtime < 500));
		printf("millisecond: %u\n", curtime);
		prevtime = curtime;
	}

	NDL_Quit();
}

//	struct timeval prev_time;
//	struct timeval current_time;
//	gettimeofday(&prev_time, NULL);
//	while(1) {
//		while(gettimeofday(&current_time, NULL) == 0 && \
//				((current_time.tv_sec == prev_time.tv_sec && current_time.tv_usec - prev_time.tv_usec < 500000) || \
//				 (current_time.tv_sec - prev_time.tv_sec == 1 && current_time.tv_usec + 1000000 - prev_time.tv_usec < 500000)));
//		printf("seconds : %ld\tmicro seconds : %ld\n", current_time.tv_sec, current_time.tv_usec);
//		prev_time = current_time;
//	}
//
//	return 0;
