#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "quad_list.h"

struct quad_list* quad_list_new(struct quad* node)
{
	struct quad_list* new = malloc(sizeof(struct quad_list));
	new->node = node;
	new->next = NULL;
	return new;
}

struct quad_list* quad_list_add(struct quad_list** dest, struct quad_list* src)
{
	if (*dest == NULL) {
		*dest = src;
	} else {
		struct quad_list* scan = *dest;
		while (scan->next != NULL)
			scan = scan->next;
		scan->next = src;
	}
	return list1;
}

struct quad_list* quad_list_complete(struct quad_list* list, struct symbol* label)
{
	while(list != NULL)
	{
		list->node->res = label;
		list = list->next;
	}
	return list;
}