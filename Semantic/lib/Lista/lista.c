#include "lista.h"

NODE* newNODE(char* lex_value, int value){
    NODE *b = malloc(sizeof(NODE));
    b->next = NULL;
    b->lex_value = lex_value;
    b->value = value;
    return b;
} 

LISTA* createLISTA(void){
    LISTA *s = malloc(sizeof(LISTA));
    s->head = NULL;

    return s;
}
int isEmpty(LISTA *s){
    return (s == NULL || s->head == NULL);
}
int insertNODE(LISTA* s, char* lex_value, int value){
    NODE *aux;

    if(isEmpty(s)){
        s->head = newNODE(lex_value, value);
        return 0;
    }
    else{
        aux = s->head;
        while(aux->next != NULL){
            if(strcmp(aux->lex_value, lex_value) == 0){
                aux->value = value;
                return 0;
            }
            aux = aux->next;
        }
        if(strcmp(aux->lex_value, lex_value) == 0){
            aux->value = value;
            return 0;
        }
        aux->next = newNODE(lex_value, value);
        return 0;
    }
}
int getValue(LISTA* s, char* lex_value){
    NODE *aux;
    if(!isEmpty(s)){
        aux = s->head;
        while(aux != NULL){
            if(strcmp(aux->lex_value, lex_value) == 0){
                return aux->value;
            }
            aux = aux->next;
        }
    }
    return -1;
}
void clearLISTA(LISTA* s){
    NODE *aux;
    if(s != NULL){
        while(!isEmpty(s)){
            aux = s->head;
            s->head = s->head->next;
            free(aux);
        }
        free(s);
    }
}
