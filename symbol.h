#ifndef SYMBOL_H
#define SYMBOL_H

#include <stdbool.h>
#define SYMBOL_MAX_NAME 32

struct symbol {
	char* identifier;
	bool isconstant;
	int value;
	struct symbol* next;
};


struct symbol* symbol_alloc();
struct symbol* symbol_newtemp(struct symbol** table);
struct symbol* symbol_add(struct symbol** table,char* identifier);
struct symbol* symbol_lookup(struct symbol* table,char* identifier);
struct symbol* symbol_newcst(struct symbol**, int value);
void symbol_print(struct symbol* symbol);
void symbol_free(struct symbol* table);



#endif
