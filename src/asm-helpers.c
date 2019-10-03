#include "builders.h"
#include "ant_engine.h"

void doPanic(char *s) {
  panic(s);
}

void debug(char *s)
{
  printf("%s\n", s);
}

void doAdjust(uint32_t *prevPos, uint32_t newPos, uint32_t limit) {
  adjust(prevPos, newPos, limit);
}