#include <NDL.h>
#include <SDL.h>
#include <assert.h>

#define keyname(k) #k,

static const char *keyname[] = {
  "NONE",
  _KEYS(keyname)
};

int SDL_PushEvent(SDL_Event *ev) {
	assert(0);
  return 0;
}

//enum SDL_EventType {
//  SDL_KEYDOWN,
//  SDL_KEYUP,
//  SDL_USEREVENT,
//};
//
//typedef struct {
//  uint8_t sym;
//} SDL_keysym;
//
//typedef struct {
//  uint8_t type;
//  SDL_keysym keysym;
//} SDL_KeyboardEvent;
//
//typedef struct {
//  uint8_t type;
//  int code;
//  void *data1;
//  void *data2;
//} SDL_UserEvent;
//
//typedef union {
//  uint8_t type;
//  SDL_KeyboardEvent key;
//  SDL_UserEvent user;
//} SDL_Event;

int SDL_PollEvent(SDL_Event *ev) {
	char buf[64];
	char kstate[3];
	char kname[32];
	if(NDL_PollEvent(buf, sizeof(buf))) {
		sscanf(buf, "%s %s", kstate, kname);
		if(strcmp(kstate, "kd") == 0) {
			ev->type == SDL_KEYDOWN;
		}
		else {
			ev->type == SDL_KEYUP;
		}
		int keyid;
		for(keyid = 0; keyid < sizeof(keyname)/sizeof(kname[0]); keyid++) {
			if(strcmp(keyname[keyid], kname) == 0)
				break;
		}
		ev->key.keysym.sym = keyid;
		return 1;
	}
	else {
		return 0;
	}
}

int SDL_WaitEvent(SDL_Event *event) {
	while(SDL_PollEvent(event) == 0);	
	return 1;
	// TODO: return 0 if there is a bug
}

int SDL_PeepEvents(SDL_Event *ev, int numevents, int action, uint32_t mask) {
	assert(0);
  return 0;
}

uint8_t* SDL_GetKeyState(int *numkeys) {
	assert(0);
  return NULL;
}
