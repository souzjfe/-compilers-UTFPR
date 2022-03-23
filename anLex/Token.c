#include <stdio.h>
#include "Token.h"

void printToken(Token t){
    printf("<%s, %d>",t.name, t.pos);
}
Token createToken(char *name, int pos){
    Token new;
    new.pos = pos;
    new.name = name;
    return new;
}