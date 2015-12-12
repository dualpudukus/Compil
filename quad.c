#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "quad.h"

struct quad* quad_malloc( int op,
struct symbol* arg1,
struct symbol* arg2,
struct symbol* res){
struct quad* new = malloc(sizeof(*new));
new->op = op;
new->arg1 = arg1;
new->arg2 = arg2;
new->res = res;
new->next = NULL;
return new;
}
void quad_add(struct quad** list, struct quad* new){
if(*list == NULL){
*list = new;
}else{
struct quad* scan = *list;
while(scan->next != NULL)
scan = scan->next;
scan->next = new;
}
}
void quad_print(struct quad* list){
while(list != NULL){
printf("%d ",list->op);
if(list->arg1 != NULL) printf(" %s ",list->arg1->id);
else printf(" vide ");
if(list->arg2 != NULL) printf(" %s ",list->arg2->id);
else printf(" vide ");
if(list->res != NULL) printf(" %s ",list->res->id);
else printf(" vide ");
printf("\n");
list = list->next;
}
}
struct quad_list* quad_list_new(struct quad* node){
struct quad_list* new = malloc(sizeof(struct quad_list));
new->node = node;
new->next = NULL;
return new;
}
struct quad_list* quad_list_add(struct quad_list* list1, struct quad_list* list2)
{
return list1;
}
struct quad_list* quad_list_complete(struct quad_list* list, struct symbol* node)
{
while(list != NULL){
list->node->res = node;
list = list->next;
}
return list;
}
