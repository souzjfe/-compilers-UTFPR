/* just like Unix wc */
%option noyywrap

%{
#include "Token.h"
#include "OrderedList.h"
#include <stdio.h>

OrderedList list;

int lines = 1;
int tabs = 0;
int chars = 0;
%}

%%
programa    	{   initOrderedList(&list);   insertOrderedList(&list, createToken("PROG",lines))  ;    }  
var             {   insertOrderedList(&list, createToken("VAR",lines))   ;    }  
verdadeiro      {   insertOrderedList(&list, createToken("TRUE",lines))  ;    }  
falso           {   insertOrderedList(&list, createToken("FALSE",lines)) ;    }  
se              {   insertOrderedList(&list, createToken("IF",lines))    ;    }  
senao           {   insertOrderedList(&list, createToken("IF",lines))    ;    }  
enquanto        {   insertOrderedList(&list, createToken("WHILE",lines)) ;    }  
inicio          {   insertOrderedList(&list, createToken("BEGIN",lines)) ;    }  
fim             {   insertOrderedList(&list, createToken("END",lines))   ;    }  
[a-zA-Z]+"(".")"       {   insertOrderedList(&list, createToken("FUNC",lines))    ;    }  
[a-zA-Z]+       {   insertOrderedList(&list, createToken("ID",lines))    ;    }  
[0-9]+          {   insertOrderedList(&list, createToken("NUM",lines))   ;    }
"("               {   insertOrderedList(&list, createToken("OPPAR",lines))   ;  }
")"               {   insertOrderedList(&list, createToken("CLPAR",lines))   ;  }
";"               {   insertOrderedList(&list, createToken("SCOL",lines))    ;  }  
"+"               {   insertOrderedList(&list, createToken("MORE",lines))    ;  }  
"-"               {   insertOrderedList(&list, createToken("MINUS",lines))   ;  }  
"*"               {   insertOrderedList(&list, createToken("MULT",lines))    ;  }  
"/"               {   insertOrderedList(&list, createToken("DIV",lines))     ;  }  
":="           {   insertOrderedList(&list, createToken("ATRIB",lines))     ;}  
"="           {   insertOrderedList(&list, createToken("EQUAL",lines))     ;}  
"<"           {   insertOrderedList(&list, createToken("SMALER",lines))     ;}  
">"           {   insertOrderedList(&list, createToken("LARGER",lines))     ;}  
\n              {   lines++; tabs=0; }
\t              {   tabs++; }
"{".*"}"        {}

%%

int main(int argc, char **argv)
{
    /* char *fileName;
    if( argc == 0)
        fileName = "test.jfe";
    else
        fileName = argv[0]; */
    FILE *file = fopen("test.jfe", "r");


    if(!file){
        printf("Arquivo não encontrado");
        return -1;
    }

    yyin = file;

    yylex();
    
    printOrderedList(&list);

    fclose(file);
    
}