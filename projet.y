%{
	//-----YACC-----
	#include <stdlib.h>
	#include <stdio.h>
	#include "quad.h"
	#include "symbol.h"
	#include "quad_list.h"
	void yyerror(char*);

	struct symbol* symbol_table = NULL;
	struct quad* code = NULL;
	int next_quad = 0;
%}

%union { 
	int value;
	char* string;
	struct symbol* code_jump;
	struct {
		struct symbol* result;
		struct quad* code;
	} code_expression;
	struct {
		struct quad* code;
		struct quad_list* truelist;
		struct quad_list* falselist;
	} code_condition;
	struct{
		struct quad* code ;
		struct quad_list* nextlist;
	}code_statement;
	struct{
		struct symbol* quad ;
		struct quad* code ;
		struct quad_list* nextlist;
	}code_goto;
}

%start axiom

%token <string> ID
%token <value> NUM
%token <string> CHAINE
%token ASSIGN TRUE FALSE
%token WHILE IF ELSE
%token PRINTMAT PRINT PRINTF
%token INT FLOAT
%token AND OR EQUAL NOT
%token MAIN RETURN
%token COMMENTAIRE

%type <code_expression> expr
%type <code_expression> statement
%type <code_expression> statement_list

%left '-' '+'
%left '*' '/'

%right '='

%left OR
%left AND
%left NOT

%%
axiom : INT MAIN '('')' '{' statement_list RETURN NUM ';''}'	{ printf("Match\n"); code = $6.code; }
	  ;

statement_list : statement 										{ $$.code = $1.code; }
			   | statement_list statement 						{ $$.code = $1.code; quad_add(&$$.code,$2.code); }
			   ;

statement : expr';' 											{ $$.code = $1.code; }
		  ;

expr : expr '+' expr 											{ 	
			  														printf("expr -> expr + expr\n");
																	$$.result	= symbol_newtemp(&symbol_table);
																	$$.code	= $1.code;
																	quad_add(&$$.code,$3.code);
																	quad_add(&$$.code, quad_gen(&next_quad, '+', $1.result, $3.result, $$.result));
																}
	 | expr '-' expr 											{
																	printf("expr -> expr - expr\n");
																	$$.result	= symbol_newtemp(&symbol_table);
																	$$.code	= $1.code;
																	quad_add(&$$.code,$3.code);
																	quad_add(&$$.code, quad_gen(&next_quad, '-', $1.result, $3.result, $$.result));
																}
	 | expr '*' expr											{	
																	printf("expr -> expr * expr\n");
																	$$.result = symbol_newtemp(&symbol_table);
																	$$.code = $1.code;
																	quad_add(&$$.code,$3.code);
																	quad_add(&$$.code, quad_gen(&next_quad, '*', $1.result, $3.result, $$.result));
																}
	 | expr '/' expr											{	
																	printf("expr -> expr * expr\n");
																	$$.result = symbol_newtemp(&symbol_table);
																	$$.code = $1.code;
																	quad_add(&$$.code,$3.code);
																	quad_add(&$$.code, quad_gen(&next_quad, '/', $1.result, $3.result, $$.result));
																}
	 | '(' expr ')'										 		{ 	
																	printf("expr -> ( expr ) \n");
																	$$.result	= $2.result;
																	$$.code	= $2.code;
																}
	 | ID														{
																	$$.result = symbol_lookup(symbol_table, $1);
																	if ($$.result == NULL)
																		$$.result = symbol_add(&symbol_table, $1);
																	$$.code = NULL;
																}
	 | NUM														{
																	$$.result = symbol_newcst(&symbol_table, $1);
																	$$.code = NULL;
																}
	 ;
%%

int main()
{
	printf("Entrez une opération \n");	
	yyparse(); //lance l'analyseur syntaxique
	return 0;
}
