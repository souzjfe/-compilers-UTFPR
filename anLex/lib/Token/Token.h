#ifndef Token_h
#define Token_h

typedef struct Token{
    int pos;
    char *name;
}Token;

void printToken(Token t);
Token createToken(char *name, int pos);

#endif