#include <string.h>
#include "Utils.h"
int contCaracter(char *string, char caracter){
    int cont = 0;
    for(int i=0; string[i]!='\0'; i++)
        if(string[i]==caracter)
            cont++;
    return cont;
}