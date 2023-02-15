#include <stack>
#include <string.h>
#include <assert.h>
#include "intStackforC.h"

class intStack {
public:
    std::stack<int> s;
};

void *createIntStack() {
    intStack *p = new intStack();
    return (void *)p; 
}

void pushIntStack(void *stack, int x) {
    intStack *p = (intStack *)stack;
    p->s.push(x);
}

void popIntStack(void *stack) {
    intStack *p = (intStack *)stack;
    p->s.pop();
}

bool isIntStackEmpty(void *stack) {
    intStack *p = (intStack *)stack;
    return p->s.empty();
}

void deleteIntStack(void *stack) {
    intStack *p = (intStack *)stack;
    delete p;
}

// assume stack is not empty
int intStackTop(void *stack) {
    assert(!isIntStackEmpty(stack));
    intStack *p = (intStack *)stack;
    return p->s.top();
}
