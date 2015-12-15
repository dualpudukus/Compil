#ifndef QUAD_LIST_H
#define QUAD_LIST_H

#include <stdio.h>
#include <stdlib.h>
#include "quad.h"
#include "symbol.h"

struct quad_list{
	struct quad* quad;
	struct quad_list* next;
};

struct quad_list* quad_list_new(struct quad* quad);
struct quad_list* quad_list_complete(struct quad_list* list,struct symbol* label);
void quad_list_add(struct quad_list** dest, struct quad_list* src);
void quad_list_free(struct quad_list* list);
void quad_list_print(struct quad_list* list);

#endif
