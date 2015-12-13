#ifndef QUAD_H
#define QUAD_H

struct quad {
	int* label;
	char op;
	struct symbol* arg1;
	struct symbol* arg2;
	struct symbol* res;
	struct quad *next;
};

struct quad* quad_gen(int*,char, struct symbol*,struct symbol*,struct symbol*)
void quad_free(struct quad*)
void quad_add(struct quad**, struct quad*)
void quad_print(struct quad*)

#endif
