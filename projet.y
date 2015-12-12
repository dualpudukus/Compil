%{
	//-----YACC-----
	#include <stdlib.h>
	#include <stdio.h>
	void yyerror(char*);
%}
%union { 
	int value;
	char* string;
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
	  ID
	| NUM
	;

statement:
	  ID ASSIGN expr
	| WHILE condition '{' statement '}'
	| IF condition '{' statement '}'
	| IF condition '{' statement ELSE statement '}'
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
