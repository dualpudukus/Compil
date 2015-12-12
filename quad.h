#ifndef QUAD_H
#define QUAD_H

struct quad {
char op;
struct symbol *arg1;
struct symbol *arg2;
struct symbol *res;
struct quad * next;

};

struct quad* quad_gen(int*,char, struct symbol*,struct symbol*,struct symbol*)
void quad_free(struct quad*)
void quad_add(struct quad**, struct quad*)
void quad_print(strudct quad*)


struct quad_list* quad_list_new(struct quad*)
void quad_list_free(struct quad_list*)
void quad_list_add(struct quad_list**, struct quad_list*)
void quad_list_complete(struct quad_list*,struct_symbol*)
void quad_list_print(struct quad_list*)

struct symbol* symbol_alloc()
void symbol_free(struct symbol*)
struct symbol* symbol_newtemp(struct symbol**)
struct symbol* symbol_newst(struct symbol**, int)
struct symbol* symbol_lookup(struct symbol*,char)
struct symbol* symbol_add(struct symbol*,char)
void symbol_print(struct symbol*)


#endif
