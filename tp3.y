{%

#include <stdio.h>
#include <stdlib.h>
#include "tp3.l"
void yyerror(char*);
int yylex();

typedef struct quad {
	int nextquad;
	char op;
	void* arg1;
	void* arg2;
	void* res;
} quad;

struct quad* quad_gen(int*, char, struct symbol*, struct symbol*, struct symbol*);
void	     quad_free(struct quad*);
void	     quad_add(struct quad**, struct quad*);
void	     quad_print(struct quad*);

struct quad_list* quad_list_new(struct quad*);
void	     quad_list_free(struct quad_list*);
void	     quad_list_add(struct quad_list** struct quad_list*);
void	     quad_list_complete(struct quad_list*, struct symbol*);
void	     quad_list_print(struct quad_list*);


}%

%union {
	char* string;
	int value;
}

%%

stmt : ID ASSIGN expr { id_add($1); $$ = $3; }

     | WHILE condition '{' stmtlist '}'
     | IF condition '{' stmtlist '}'
     | IF condition '{' stmtlist ELSE '{' stmtlist '}'
     ;

stmtlist : stmtlist stmt
	 | stmt
	 ;

expr : ID	{ if (id_find($1) == 0) $$ = $1; }
     | NUM	{ //verifier dans la table des symboles si l'expression existe déjà $$ = $1; }
     ;

condition : ID EQUAL ID
	  | ID SUP
	  | ID INF ID
	  | NUM EQUAL NUM
	  | NUM SUP NUM
	  | NUM INF NUM
	  | ID EQUAL NUM
	  | ID SUP NUM
	  | ID INF NUM
	  | NUM EQUAL ID
	  | NUM SUP ID
	  | NUM INF ID
	  | TRUE
	  | FALSE
	  | condition OR condition
	  | condition AND condition
	  | NOT condition
	  | '(' condition ')'
	  ;


%%

int main() {

	printf("Bonsoir YACC\n");
	yyparse();
	return 0;

}
