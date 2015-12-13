#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol.h"

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

struct symbol* symbol_add(struct symbol** table, char* identifier)
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

struct symbol* symbol_newtemp(struct symbol** table) 
{
	static int symbol_temp_number = 0;
	char name_temp[SYMBOL_MAX_NAME];
	snprintf(name_temp,SYMBOL_MAX_NAME,"temp_%d",symbol_temp_number++);
	return symbol_add(table,name_temp);
}


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

struct symbol* symbol_newcst(struct symbol** table, int value)
{
	static int symbol_constant_number = 0;
	char name_constant[SYMBOL_MAX_NAME];
	snprintf(name_constant,SYMBOL_MAX_NAME,"cst_%d",symbol_constant_number++);
	*table = symbol_alloc();
	(*table)->value = value;
	(*table)->isconstant = true;
	return symbol_add(table,name_constant);
}

void symbol_print(struct symbol* symbol)
{
	while (symbol != NULL) 
	{
		printf("id: %7s, isconstant: %d, value: %d\n",
		symbol->identifier, symbol->isconstant, symbol->value);
		symbol = symbol->next;
	}
}

void symbol_free(struct symbol* table)
{
	free(table->identifier);
	free(table);
}

int main()
{
}
