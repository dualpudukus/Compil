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
	  expr PLUS expr 										{ 	
		  														printf("expr -> expr + expr\n");
																$$.result	= symbol_newtemp(&tds);
																$$.code	= $1.code;
																quad_add(&$$.code,$3.code);
																quad_add(&$$.code, quad_gen(_PLUS,$1.result,$3.result,$$.result));
															}
	| expr MOINS expr 										{
																printf("expr -> expr - expr\n");
																$$.result	= symbol_newtemp(&tds);
																$$.code	= $1.code;
																quad_add(&$$.code,$3.code);
																quad_add(&$$.code, quad_gen(_MOINS,$1.result,$3.result,$$.result));
															}
	| expr MUL expr											{	
																printf("expr -> expr * expr\n");
																$$.result = symbol_newtemp(&tds);
																$$.code = $1.code;
																quad_add(&$$.code,$3.code);
																quad_add(&$$.code, quad_gen(_MUL,$1.result,$3.result,$$.result));
															}
	| expr DIV expr											{	
																printf("expr -> expr * expr\n");
																$$.result = symbol_newtemp(&tds);
																$$.code = $1.code;
																quad_add(&$$.code,$3.code);
																quad_add(&$$.code, quad_gen(_DIV,$1.result,$3.result,$$.result));
															}
	| '(' expr ')'									 		{ 	
																printf("expr -> ( expr ) \n");
																$$.result	= $2.result;
																$$.code	= $2.code;
															}
	| ID													{
																$$.result = symbol_lookup(symbol_table, $1);
																if ($$.result == NULL)
																	$$.result = symbol_add(&symbol_table, $1);
																$$.code = NULL;
															}
	| NUM													{
																$$.result = symbol_newcst(&symbol_table, $1);
																$$.code = NULL;
															}
	;

statement:
	  ID ASSIGN expr 										{
																$$.result = symbol_add(&tds,$2);							
																$$.code=NULL;
																quad_add(&$$.code, quad_gen(_AFFECT,$4.result,NULL,$$.result));
															}
	| WHILE condition '{' statement '}'
	| IF condition '{' statement '}'					{ }
	| IF condition '{' statement ELSE statement '}'		{ }
	;

statement_list:
	  statement_list statement
	| statement
	;

condition:
	  expr '>' expr 										{
		  														struct quad* goto_true;
																struct quad* goto_false;
																quad_add(&goto_true, quad_gen('>',$1.result,$3.result,NULL));
																quad_add(&goto_false, quad_gen('G',NULL,NULL,NULL));
																$$.code	= $1.code;
																quad_add(&$$.code, $3.code);
																quad_add(&$$.code, goto_true);
																quad_add(&$$.code, goto_false);
																$$.truelist	= quad_list_new(goto_true);
																$$.falselist = quad_list_new(goto_false);	
		  													}
	| expr '<' expr 										{
		  														struct quad* goto_true;
																struct quad* goto_false;
																quad_add(&goto_true, quad_gen('<',$1.result,$3.result,NULL));
																quad_add(&goto_false, quad_gen('G',NULL,NULL,NULL));
																$$.code	= $1.code;
																quad_add(&$$.code, $3.code);
																quad_add(&$$.code, goto_true);
																quad_add(&$$.code, goto_false);
																$$.truelist	= quad_list_new(goto_true);
																$$.falselist = quad_list_new(goto_false);
		  													}
	| expr EQUAL expr										{

															}
	| TRUE
	| FALSE
	| condition AND tag condition 							{
																quad_list_complete($1.falselist,$3.result);
																quad_list_add($1.falselist, $4.falselist);
																$$.falselist = $1.falselist;
																$$.truelist = $4.truelist;
																$$.code = $1.code;
																quad_add(&$1.code,$4.code);
															}
	| condition OR tag condition 							{ 
																quad_list_complete($1.falselist, $3.result);
																$$.code = $1.code;
																quad_add($$.code, $4.code);
																$$.falselist = $4.falselist;
																$$.truelist = $1.truelist;
																quad_list_add($$.truelist, $4.truelist);
															}
	| NOT condition 										{ 
																$$.code = $2.code;
																$$.truelist = $2.falselist;
																$$.falselist = $2.truelist;
															}
	| '(' condition ')'										{ 
																$$.code = $2.code;
																$$.truelist = $2.truelist;
																$$.falselist = $2.falselist;
															}
	;

tag:
	{ 	$$.result = symbol_newtemp(&tds);
		$$.result->value = next; 
		$$.code = NULL;
	};

%%

int main()
{
	printf("Entrez une opération \n");	
	yyparse(); //lance l'analyseur syntaxique
	return 0;
}
