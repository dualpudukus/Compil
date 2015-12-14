#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "quad_list.h"
#include "quad.c"

struct quad_list* quad_list_new(struct quad* node)
{
	struct quad_list* new = malloc(sizeof(struct quad_list));
	new->node = node;
	new->next = NULL;
	return new;
}

void quad_list_add(struct quad_list** dest, struct quad_list* src)
{
	if (*dest == NULL) {
		*dest = src;
	} else {
		struct quad_list* scan = *dest;
		while (scan->next != NULL)
			scan->next = src;
	}
}

void quad_list_complete(struct quad_list* list, struct symbol* label)
{
	while(list != NULL)
		list->node->res = label;
}

void quad_list_free(struct quad_list* list)
{
	while(list != NULL)
		quad_free(list->node);
}

void quad_list_print(struct quad_list* list)
{
	while(list != NULL)
		quad_print(list->node);
}

