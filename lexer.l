%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/* Choisit une longueur de tableau arbitraire,
 * l'essentiel étant de garder un lien entre la taille du tableau
 * et l'indice retourné par la fonction de hachage
 * d'où l'utilité du modulo à la fin de cette dernière.
 */
#define TAB_SYMBOLE_LONGUEUR 1000

/* On créé le tableau qui contiendra les identificateurs.
 * Sa longueur importe peu puisque les clés associées aux valeurs du tableau
 * sont créées par la fonction de hachage et ne se suivent donc pas forcément.
 */
char* symboles[TAB_SYMBOLE_LONGUEUR];

/* Algorithme "djb2" par Dan Berstein pour générer un nombre à partir d'une "chaîne de caractères", 
 * le nombre de collisions (= même clef générée pour deux chaînes différentes) est assez bas.
 */
unsigned long hash(unsigned char* str)
{
	unsigned long hash = 5381;
        int c;

        while ((c = *str++) != 0)
            hash = ((hash << 5) + hash) + c; /* hash * 33 + c */
	    hash = hash % 1000; /* On réduit le nombre donné par souci de lisibilité */

        return hash;
}

/* Fonction traitant l'ajout de l'identificateur détecté par la regexp dans le tableau de symboles,
 * on alloue l'espace mémoire équivalent au yytext - l'identificateur détécté - puis on le copie,
 * et la valeur copiée est assignée à une case du tableau définie par la fonction de hachage.
 */
void id_add(char* str)
{
	char* id = malloc(strlen(yytext)+1);
	symboles[hash(yytext)] = strcpy(id, yytext);
}

%}

identificateur	 	[_a-zA-Z][_a-zA-Z0-9]*

%%

\+                      		{ printf(" 1 "); /* Opérateurs arithmétiques / d'assignation */ }
\-                      		{ printf(" 2 "); }
\*                      		{ printf(" 3 "); }
\/                      		{ printf(" 4 "); }
%					{ printf(" 5 "); }
\=					{ printf(" 10 "); }

\<					{ printf(" 12 "); /* Opérateurs de comparaison */ }
\<=					{ printf(" 13 "); }
\>					{ printf(" 14 "); }
\>=					{ printf(" 15 "); }
\=\=					{ printf(" 16 "); }
\!=					{ printf(" 17 "); }

!					{ printf(" 11 "); /* Opérateurs logiques / binaires */ }
&					{ printf(" 18 "); }
\|					{ printf(" 19 "); }
&&                      		{ printf(" 20 "); }
\|\|                    		{ printf(" 21 "); }

\{                      		{ printf(" 30 "); /* Opérateurs jumelés */ }
\}                      		{ printf(" 31 "); }
«                       		{ printf(" 32 "); }
»                       		{ printf(" 33 "); }
\[                      		{ printf(" 34 "); }
\]                      		{ printf(" 35 "); }
\(					{ printf(" 36 "); }
\)					{ printf(" 37 "); }

,					{ printf(" 40 "); /* Ponctuation */ }
'					{ printf(" 41 "); }
;					{ printf(" 42 "); }

cin					{ printf(" 50 "); /* Mots-clés du langage C- */ }
const					{ printf(" 51 "); }
cout					{ printf(" 52 "); }
else					{ printf(" 53 "); }
if                      		{ printf(" 54 "); }
typedef					{ printf(" 55 "); }
while                   		{ printf(" 56 "); }

[0-9]+					{ printf("[ 60 - %s ]", yytext); /* Détecte une constante entière */ }
('.{1}')|'\\.{1}'			{ printf("[ 61 - %s ]", yytext); /* Détecte une constante caractère */ }
[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?	{ printf("[ 62 - %s ]", yytext); /* Détecte une constante flottante */ }

char|int|float|void|main		{ printf("[ 70 - %lu ]", hash(yytext));
					  id_add(yytext); /* Identificateurs prédéfinis du C- */ }
{identificateur}			{ printf("[ 71 - %lu ]", hash(yytext));
					  id_add(yytext); /* Identificateurs créés par le programmeur */ }

%%

int main(int argc, char *argv[])
{

	int i;	

	/* On ouvre le fichier indiqué en argument au lancement du programme */
	if ( argc > 2 )
	{	
		printf("Indiquez un seul fichier en argument (ou aucun pour stdin) : <programme> <fichier>\n");
		exit(1);
	}	

	yyin = fopen(argv[1], "r");    
	
	/* Analyse lexicale */

	yylex();

	/* Affiche la liste des identificateurs */

	printf("Liste des identificateurs:\n");
	printf("Table des symboles ( Indice | Identificateur )\n");	

	for (i = 0; i < TAB_SYMBOLE_LONGUEUR; i++)
	{
		if (symboles[i] != NULL)
		{
			printf(" %i | %s \n", i, symboles[i]);
		}
		else
		{
			continue;
		}
	}
	return 0;
}
