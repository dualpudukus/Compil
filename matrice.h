#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct matrice {
	double** valeurs;
	int lignes;
	int colonnes;
};

typedef struct matrice matrice;

matrice *creationMatrice(int LIGNES, int COLONNES);
void affichageMatrice(matrice *mat);
matrice *copieMatrice(matrice *mat);
matrice *transpose(matrice *mat);
matrice *triangulaireInferieure(matrice *I, matrice *b);
matrice *triangulaireSuperieure(matrice *J, matrice *b);
matrice *somme(matrice *A, matrice *b);
matrice *soustraction(matrice *A, matrice *b);
matrice *produit(matrice *A, matrice *b);
matrice *division(matrice *A, matrice *b);