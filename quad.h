#ifndef QUAD_H
#define QUAD_H

#include <stdlib.h>
#include <stdio.h>
#include "symbol.h"

struct quad {
	int* label;
	char op;
	struct symbol* arg1;
	struct symbol* arg2;
	struct symbol* res;
	struct quad *next;
};

struct quad* quad_gen(int* label,char op, struct symbol* arg1,struct symbol* arg2,struct symbol* res);
void quad_free(struct quad* quad);
void quad_add(struct quad** dest, struct quad* src);
void quad_print(struct quad* quad);

#endif
