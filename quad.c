#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "quad.h"
#include "symbol.h"

struct quad* quad_gen(int op,struct symbol* arg1,struct symbol* arg2,struct symbol* res)
{
	struct quad* new = malloc(sizeof(struct quad));
	new->label = *label;
	(*label)++;
	new->op = op;
	new->arg1 = arg1;
	new->arg2 = arg2;
	new->res = res;
	new->next = NULL;
	return new;
}

void quad_free(struct quad* quad)
{
	struct quad* next;
	while (quad != NULL)
	{
		next = quad->next;
		free(quad);
		quad = next;
	}
}


void quad_add(struct quad** dest, struct quad* src)
{
	if(*dest == NULL)
	{
		*dest = src;
	} else {
		struct quad* scan = *dest;
		while(scan->next != NULL)
			scan = scan->next;
		scan->next = src;
	}
}

void quad_print(struct quad* list)
{
	int i = 0;
	while(list != NULL)
	{
		printf("Node %2d:\n", i);
		quad_print(list->node);
		printf("\n");
		list = list->next;
	}
}