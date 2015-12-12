#ifndef SYMBOL_H
#define SYMBOL_H


struct symbol* symbol_alloc()
void symbol_free(struct symbol*)
struct symbol* symbol_newtemp(struct symbol**)
struct symbol* symbol_newst(struct symbol**, int)
struct symbol* symbol_lookup(struct symbol*,char)
struct symbol* symbol_add(struct symbol*,char)
void symbol_print(struct symbol*)

#endif
