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
	  ID ASSIGN expr 									{
															$$.result = symbol_add(&tds,$2);							
															$$.code=NULL;
															quad_add(&$$.code, quad_malloc(_AFFECT,$4.result,NULL,$$.result));
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
	 ID EQUAL NUM
	| TRUE
	| FALSE
	| condition AND tag condition 							{
																quad_list_complete($1.falselist,$3.result);
																$$.code = $1.code;
																quad_add(&$1.code,$4.code);
																$$.falselist = $4.falselist;
																$$.truelist = $1.truelist;
																quad_list_add($$.truelist,$4.truelist);
															}
	| condition OR tag condition 							{ 
																quad_list_complete($1.falselist, $3.result);
																quad_list_add($$.truelist, $4.truelist);
																quad_list_add($$.truelist, $1.truelist);
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
