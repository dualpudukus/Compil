%{
	//-----YACC-----
	#include <stdlib.h>
	#include <stdio.h>
	void yyerror(char*);
%}
%union { 
	int value;
	char* string;
	struct {
		struct symbol* result;
		struct quad* code;
	} code_expression;
	struct {
		struct quad* code;
		struct quad_list* truelist;
		struct quad_list* falselist;
	} code_condition;
}

%token <string> ID
%token <value> NUM
%token <string> CHAINE
%token ASSIGN WHILE IF ELSE PRINTF INT FLOAT AND OR EQUAL NOT SUPEQ INFEQ SUP INF RETURN TRUE FALSE PRINT PRINTF PRINTMAT

%%
axiom:
	 statement '\n' //{printf("%d\n",$1);}
	;

expr:
	  ID	{
	  			$$.result = symbol_lookup(symbol_table, $1);
	  			if ($$.result == NULL)
	  				$$.result = symbol_add(&symbol_table, $1);
	  				$$.code = NULL;
	  		}
	| NUM	{
				$$.result = symbol_newcst(&symbol_table, $1);
				$$.code = NULL;
			}
	;

statement:
	  ID ASSIGN expr
	| WHILE condition '{' statement '}'
	| IF condition '{' statement '}'					{ }
	| IF condition '{' statement ELSE statement '}'		{ }
	;

statement_list:
	  statement_list statement
	| statement
	;

condition:
	 ID EQUAL NUM
	| TRUE
	| FALSE
	| condition OR condition
	| condition AND condition
	| NOT condition
	| '(' condition ')'
	;

%%

int main()
{
	printf("Entrez une opération \n");	
	yyparse(); //lance l'analyseur syntaxique
	return 0;
}
