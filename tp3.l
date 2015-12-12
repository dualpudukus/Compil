{%

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TAB_SYMBOLE_LONGUEUR 1000
char* symboles[TAB_SYMBOLE_LONGUEUR];

unsigned long hash(unsigned char* str)
{
	unsigned long hash = 5381;
        int c;

        while ((c = *str++) != 0)
            hash = ((hash << 5) + hash) + c; /* hash * 33 + c */
	    hash = hash % 1000; /* On réduit le nombre donné par souci de lisibilité */

        return hash;
}

void id_add(char* str)
{
	char* id = malloc(strlen(str)+1);
	symboles[hash(str)] = strcpy(id, str);
}

int id_find(char* id)
{
	if (symboles[hash(id)] == NULL) {
		perror("Identifier not declared.\n");
		exit(1);
	} else {
		return 0;
	}
}

}%

{identifier}	[_a-zA-Z][_a-zA-Z0-9]
{number}	[0-9]+

%%

==		{ return EQUAL; }
!		{ return NOT; }
[=]		{ return ASSIGN; }
(		{ return OPAR; }
)		{ return CPAR; }
if		{ return IF; }
while		{ return WHILE; }
else		{ return ELSE; }
[{}]		{ return yytext[0]; }
&&		{ return AND; }
||		{ return OR; }
{identifier}	{ id_add(yytext);
		  return ID; }
{number}	{ return NUM; }
[\n]		{ return yytext[0]; }

%%

int main() {

	printf("Bonsoir LEX\n");
	yylex();
	return 0;

}
