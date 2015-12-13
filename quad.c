#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "quad.h"
#include "symbol.h"

struct quad* quad_gen(int op,struct symbol* arg1,struct symbol* arg2,struct symbol* res)
{
	struct quad* new = malloc(sizeof(*new));
	new->label = next_quad++;
	new->op = op;
	new->arg1 = arg1;
	new->arg2 = arg2;
	new->res = res;
	new->next = NULL;
	return new;
}

void quad_add(struct quad** list, struct quad* new){
	if(*list == NULL)
	{
		*list = new;
	} else {
		struct quad* scan = *list;
		while(scan->next != NULL)
			scan = scan->next;
		scan->next = new;
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