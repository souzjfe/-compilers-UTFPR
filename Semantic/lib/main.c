#include <stdio.h>
#include "../build/lex.yy.h"

extern int yyparse (void);


void yyerror(char const *message){
    printf("\nError: %s", message);
}

int main(int argc, char const *argv[]) {
    
    if(!argv[1]){
        printf("Arquivo não encontrado");
        return -1;
    }

    yyin = fopen(argv[1], "r");
    int result_code = yyparse();
    fclose(yyin);

    return result_code;
    
}



