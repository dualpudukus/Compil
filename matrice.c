#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "matrice.h"

/* Création de la matrice */
matrice *creationMatrice(int LIGNES, int COLONNES)
{
    int i, j;
    matrice *mat = malloc(sizeof(matrice));
    (*mat).lignes = LIGNES;
    (*mat).colonnes = COLONNES;
    (*mat).valeurs = malloc(LIGNES *sizeof(double*));

    for(i = 0; i < LIGNES; i++)
        {
            (*mat).valeurs[i] = malloc(COLONNES *sizeof(double));

            for(j = 0; j < COLONNES; j++)
            {
                (*mat).valeurs[i][j] = 0;
            }
        }
    return mat;
}

/* Affichage de la matrice */
void affichageMatrice(matrice *mat)
{
    int k,l;
    for(k = 0; k < (*mat).lignes; k++)
        {
            for(l = 0; l < (*mat).colonnes; l++)
            {
                printf("%.1f | ",(*mat).valeurs[k][l]);
            }
            printf("\n");
        }
}

/* Copie de Matrice */
matrice *copieMatrice(matrice *mat)
{
	int m,n;
	matrice *cop = creationMatrice((*mat).lignes,(*mat).colonnes);
	for(m = 0; m < (*cop).lignes ; m++)
	{
		for(n = 0; n < (*cop).colonnes; n++)
		{
			 (*cop).valeurs[n][m] = (*mat).valeurs[n][m];
		}
	}
	return cop;
}

/* transpose de la Matrice */
matrice *transpose(matrice *mat)
{
    int i,j;
    matrice  *trans = creationMatrice((*mat).lignes,(*mat).colonnes);

    for(i = 0 ; i < (*trans).lignes; i++)
    {
        for(j = 0 ; j < (*trans).colonnes; j++)
        {
            (*trans).valeurs[i][j] = (*mat).valeurs[j][i];
        }
    }
  return trans;
}

/* Triangulaire Inferieure */
matrice *triangulaireInferieure(matrice *I, matrice *b)
{
    matrice *triInf = creationMatrice((*I).lignes,1);
    int i, j;
    for (i = 0; i < (*I).lignes; i++)
	{
		(*triInf).valeurs[i][0] = 0;
		for (j = 0; j < i; j++)
		{
			(*triInf).valeurs[i][0] += (*I).valeurs[i][j]*(*triInf).valeurs[j][0];
		}
		(*triInf).valeurs[i][0]=((*b).valeurs[i][0] - (*triInf).valeurs[i][0]) / (*I).valeurs[i][i];
	}
	return triInf;

}

/* Triangulaire Superieure */
matrice *triangulaireSuperieure(matrice *J, matrice *b)
{
    matrice *triSup = creationMatrice((*J).lignes,1);
    int i, j;
    for (i = (*J).lignes - 1 ; i >= 0; i--)
	{
		(*triSup).valeurs[i][0] = 0;
		for (j = i+1; j < (*J).lignes; j++)
		{
			(*triSup).valeurs[i][0] += (*J).valeurs[i][j]*(*triSup).valeurs[j][0];
		}
		(*triSup).valeurs[i][0]=((*b).valeurs[i][0] - (*triSup).valeurs[i][0]) / (*J).valeurs[i][i];
	}
	return triSup;

}

matrice *somme(matrice *A, matrice *b){
  matrice *res = creationMatrice((*A).lignes,(*A).colonnes);
  int i,j;

  for(i = 0;  i < (*A).lignes; i++)
  {
    for(j = 0; j < (*A).colonnes; j++)
    {
      (*res).valeurs[i][j] = (*A).valeurs[i][j] + (*b).valeurs[i][j];
    }
  }
  return res;
}

matrice *soustraction(matrice *A, matrice *b){
  matrice *res = creationMatrice((*A).lignes,(*A).colonnes);
  int i,j;

  for(i = 0;  i < (*A).lignes; i++)
  {
    for(j = 0; j < (*A).colonnes; j++)
    {
      (*res).valeurs[i][j] = (*A).valeurs[i][j] - (*b).valeurs[i][j];
    }
  }
  return res;
}

matrice *produit(matrice *A, matrice *b){
  matrice *res = creationMatrice((*A).lignes,(*A).colonnes);
  int i,j;

  for(i = 0;  i < (*A).lignes; i++)
  {
    for(j = 0; j < (*A).colonnes; j++)
    {
      (*res).valeurs[i][j] = (*A).valeurs[i][j] * (*b).valeurs[i][j];
    }
  }
  return res;
}
matrice *division(matrice *A, matrice *b){
  matrice *res = creationMatrice((*A).lignes,(*A).colonnes);
  int i,j;

  for(i = 0;  i < (*A).lignes; i++)
  {
    for(j = 0; j < (*A).colonnes; j++)
    {
      (*res).valeurs[i][j] = (*A).valeurs[i][j] / (*b).valeurs[i][j];
    }
  }
  return res;
}
