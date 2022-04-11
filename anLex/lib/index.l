/* flex wc.l && gcc lex.yy.c Token.c OrderedList.c -o jfe -lfl*/
%option noyywrap

%{
#include <stdio.h>
#include "Utils/Utils.h"
#include "OrderedList/OrderedList.h"
#include "Token/Token.h"

OrderedList list;

int lines = 1;
int tabs = 0;
int chars = 0;
%}

id [[:alpha:]_][[:alnum:]_]*
natural [0-9]+
integer "-"?{natural}
real    {integer}"."{natural}

%%
programa    	                {   initOrderedList(&list);   insertOrderedList(&list, createToken("PROG",lines)); }  
var                             {   insertOrderedList(&list, createToken("VAR",lines)); }  
verdadeiro                      {   insertOrderedList(&list, createToken("TRUE",lines)); }  
falso                           {   insertOrderedList(&list, createToken("FALSE",lines)); }  
se                              {   insertOrderedList(&list, createToken("IF",lines)); }  
senao                           {   insertOrderedList(&list, createToken("IF",lines)); }  
enquanto                        {   insertOrderedList(&list, createToken("WHILE",lines)); }  
inicio                          {   insertOrderedList(&list, createToken("BEGIN",lines)); }
faca                            {   insertOrderedList(&list, createToken("DO",lines)); }
fim                             {   insertOrderedList(&list, createToken("END",lines)); }  
:=                              {   insertOrderedList(&list, createToken("ATRIB",lines)); }  
;                               {   insertOrderedList(&list, createToken("SCOL",lines)); }  
:                               {   insertOrderedList(&list, createToken("DOUBPO",lines)); }  
{real}                          {   insertOrderedList(&list, createToken("NUMR",lines)); }
{natural}                       {   insertOrderedList(&list, createToken("NUMN",lines)); }
{integer}                       {   insertOrderedList(&list, createToken("NUMI",lines)); }
([0-9][[:alpha:]_]+[0-9]*)+     {   insertOrderedList(&list, createToken("ERRO",lines)); }
{id}                            {   insertOrderedList(&list, createToken("ID",lines)); }  
[(]                             {   insertOrderedList(&list, createToken("OPPAR",lines)); }
[)]                             {   insertOrderedList(&list, createToken("CLPAR",lines)); }
[+]                             {   insertOrderedList(&list, createToken("MORE",lines)); }  
[-]                             {   insertOrderedList(&list, createToken("MINUS",lines)); }  
[*]                             {   insertOrderedList(&list, createToken("MULT",lines)); }  
[/]                             {   insertOrderedList(&list, createToken("DIV",lines)); }  
[,]                             {   insertOrderedList(&list, createToken("VIRG",lines)); }  
[=]                             {   insertOrderedList(&list, createToken("EQUAL",lines)); }  
[<]                             {   insertOrderedList(&list, createToken("SMALER",lines)); }  
[>]                             {   insertOrderedList(&list, createToken("LARGER",lines)); }  
\n                              {   lines++; tabs=0; }
\t                              {   tabs++; }
[[:space:]]                     {}
[{][^}]*[}]                     { lines += contCaracter(yytext,'\n'); }  
.                               {chars++; printf("aqui tem um qualquer\t%d\t %s\t",lines,yytext);}
%%

int main(int argc, char **argv)
{
    /* char *fileName;
    if( argc == 0)
        fileName = "test.jfe";
    else
        fileName = argv[0]; */
    FILE *file = fopen("../tests/test.jfe", "r");


    if(!file){
        printf("Arquivo não encontrado");
        return -1;
    }

    yyin = file;

    yylex();
    
    printOrderedList(&list);

    fclose(file);
    
}