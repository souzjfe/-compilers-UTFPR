#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct NODE NODE;
typedef struct LISTA LISTA;

struct NODE{
    int value;
    char* lex_value;
    NODE* next;
};

struct LISTA{
    NODE* head;
};

NODE* newNODE(char* lex_value, int value);
LISTA* createLISTA(void);
int isEmpty(LISTA *s);
int insertBox(LISTA* s, char* lex_value, int value);
int getValue(LISTA* s, char* lex_value);
void clearLISTA(LISTA* s);