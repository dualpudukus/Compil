#ifndef SYMBOL_H
#define SYMBOL_H

#include <stdbool.h>

struct symbol {
	char* identifier;
	bool isconstant;
	int value;
	struct symbol* next;
};

struct symbol* symbol_alloc();
struct symbol* symbol_newtemp(struct symbol**);

/*void symbol_free(struct symbol*);
struct symbol* symbol_newst(struct symbol**, int);
struct symbol* symbol_lookup(struct symbol*,char);
struct symbol* symbol_add(struct symbol*,char);
void symbol_print(struct symbol*);
 */
#endif
