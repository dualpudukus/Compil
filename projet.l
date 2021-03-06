%{
	//-----LEX------
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "y.tab.h"
%}

identifier 		[_a-zA-Z][_a-zA-Z0-9]*
number 			[0-9]+
chaine 			\"(\\.|[^\"\\])*\"
commentaire		(\/\*([^*]|[\r\n]|(\*+([^*\/]|[\r\n])))*\*+\/)|(\/\/.*)

%%

[{}(),;] 			{return yytext[0];}
[\+\-\*\/] 			{return yytext[0];}

"main"				{return MAIN;}
"while" 			{return WHILE;}
"if" 				{return IF;}
"else" 				{return ELSE;}
"print" 			{return PRINT;}
"printf" 			{return PRINTF;}
"printmat" 			{return PRINTMAT;}
"int" 				{return INT;}
"float" 			{return FLOAT;}

"&&" 				{return AND;}
"||" 				{return OR;}
[=] 				{return ASSIGN;}
"==" 				{return EQUAL;}
"!" 				{return yytext[0];}
">=" 				{return SUPEQ;}
"<=" 				{return INFEQ;}
">" 				{return yytext[0];}
"<" 				{return yytext[0];}

"return" 			{return RETURN;}

"true" 				{return TRUE;}
"false" 			{return FALSE;}

{identifier}		{yylval.string = strdup(yytext);return ID;}
{number} 			{yylval.value = atoi(yytext); return NUM; }
{chaine} 			{yylval.string = strdup(yytext);return CHAINE;}
{commentaire}		{return COMMENTAIRE;}

[\n] 
. 
%%

