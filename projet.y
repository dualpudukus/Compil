%{
	//-----YACC-----
	#include <stdlib.h>
	#include <stdio.h>
	#include "quad.c"
	#include "symbol.c"
	#include "quad_list.c"
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
}

%start axiom

%token <string> ID
%token <value> NUM
%token <string> CHAINE
%token ASSIGN TRUE FALSE
%token WHILE IF ELSE
%token PRINTMAT PRINT PRINTF
%token INT FLOAT
%token AND OR EQUAL NOT SUPEQ INFEQ
%token MAIN RETURN
%token COMMENTAIRE

%type <code_expression> axiom
%type <code_expression> statement_list
%type <code_expression> statement
%type <code_expression> expr


%right '='
%left '-' '+'
%left '*' '/'


%left OR
%left AND
%left '!'

%%
axiom : INT MAIN '('')' '{' statement_list RETURN NUM ';''}'	{ printf("Match with main\n"); code = $6.code; }
	  | statement_list											{ printf("Match\n"); code = $1.code; }
	  ;

statement_list : statement 										{ 
																	printf("statement_list -> statement");
																	$$.code = $1.code; 
																}
			   | statement_list statement 						{
			   														printf("statement_list -> statement_list statement\n");
			   														$$.code = $1.code; 
			   														quad_add(&$$.code,$2.code); }
			   ;

statement : INT ID '=' expr';'									{
																	printf("statement -> ID '=' expr\n");
																	$$.result = symbol_add(&symbol_table, $2);							
																	$$.code=NULL;
																	quad_add(&$$.code, quad_gen(&next_quad, '=', $4.result, NULL, $$.result));
																}
		  | expr';'	 											{ printf("statement -> expr\n"); $$.code = $1.code; }
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
																	printf("expr -> expr / expr\n");
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
																	printf("expr -> ID\n");
																	$$.result = symbol_lookup(symbol_table, $1);
																	if ($$.result == NULL)
																		$$.result = symbol_add(&symbol_table, $1);
																	$$.code = NULL;
																}
	 | NUM														{
	 																printf("expr -> NUM\n");
																	$$.result = symbol_newcst(&symbol_table, $1);
																	$$.code = NULL;
																}
	 ;
%%

int main()
{
	printf("Entrez une opération \n");	
	yyparse(); //lance l'analyseur syntaxique
	printf("Table des symboles :\n");
	symbol_print(symbol_table);
	printf("---\n");
	printf("Liste des quads :\n");
	quad_print(code);
	return 0;
}
