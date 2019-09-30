#include "builders.h"
#include "ant_engine.h"

void doPanic(char *s) {
  panic(s);
}

void doPanicd(char *s, orientation_t orientation) {
  //panicd(s, orientation);
}

void debug(char *s)
{
  printf("%s\n", s);
}

void doAdjust(uint32_t *x, uint32_t y, orientation_t orientation) {
  adjust(x, y, orientation);
}