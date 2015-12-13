#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol.h"

static int symbol_temp_number = 0;

struct symbol* symbol_alloc()
{
	struct symbol* new;
	new = (struct symbol*)malloc(sizeof(struct symbol));
	new->identifier = NULL;
	new->value = 0;
	new->isconstant = false;
	new->next = NULL;
	return new;
}

struct symbol* symbol_newtemp(struct symbol** table, int* tag) 
{
	struct symbol* scan;
	char nametemp[SYMBOL_MAX_STRING];
	sprintf(nametemp, "temp_%d", *tag);
	symbol_add(table, nametemp);
	(*tag)++;
	scan = *table;
	while (scan->next != NULL)
		scan = scan->next;
	return scan;
}

/*
struct symbol* symbol_lookup(struct symbol* table, char* identifier)
{
	while (table != NULL)
	{
		if (strcmp(table->identifier, identifier) == 0)
		return table;
	table = table->next;
	}
	return NULL;
}

void symbol_add(struct symbol** table, char* identifier)
{
	struct symbol* scan;
	if (*table == NULL) 
	{
		*table = symbol_alloc();
		(*table)->identifier = strdup(identifier);
	} else {
		scan = *table;
		while (scan->next != NULL)
			scan = scan->next;
		scan->next = symbol_alloc();
		scan->next->identifier = strdup(identifier);
	}
}

void symbol_print(struct symbol* symbol)
{
	while (symbol != NULL) 
	{
		printf("id: %7s, isconstant: %d, value: %d\n",
		symbol->identifier, symbol->isconstant, symbol->value);
		symbol = symbol->next;
	}
} */

int main ()
{
}
