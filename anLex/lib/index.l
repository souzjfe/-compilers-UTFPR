/* flex wc.l && gcc lex.yy.c Token.c OrderedList.c -o jfe -lfl*/
%option noyywrap

%{
#define RED      "\x1b[31m" //cores em ANSI utilizadas 
#define GRAY     "\e[0;37m"
#include <stdio.h>
#include "Utils/Utils.h"
#include "OrderedList/OrderedList.h"
#include "Token/Token.h"

OrderedList list;

int lines = 1;
int tabs = 0;
int chars = 0;
int errors = 0;
%}

id [[:alpha:]_][[:alnum:]_]*
natural [0-9]+
integer "-"?{natural}
real    {integer}"."{natural}

%%
programa    	                {   insertOrderedList(&list, createToken("PROG",lines)); }  
var                             {   insertOrderedList(&list, createToken("VAR",lines)); }  
verdadeiro                      {   insertOrderedList(&list, createToken("TRUE",lines)); }  
falso                           {   insertOrderedList(&list, createToken("FALSE",lines)); }  
e                               {   insertOrderedList(&list, createToken("AND",lines)); }  
ou                              {   insertOrderedList(&list, createToken("OU",lines)); }  
se                              {   insertOrderedList(&list, createToken("IF",lines)); }  
senao                           {   insertOrderedList(&list, createToken("IF",lines)); }  
enquanto                        {   insertOrderedList(&list, createToken("WHILE",lines)); }  
inicio                          {   insertOrderedList(&list, createToken("BEGIN",lines)); }
fim                             {   insertOrderedList(&list, createToken("END",lines)); }  
faca                            {   insertOrderedList(&list, createToken("DO",lines)); }
leia                            {   insertOrderedList(&list, createToken("SCAN",lines)); }
escreva                         {   insertOrderedList(&list, createToken("PUT",lines)); }
inteiro                         {   insertOrderedList(&list, createToken("INT",lines)); }
real                            {   insertOrderedList(&list, createToken("FLOAT",lines)); }
booleano                        {   insertOrderedList(&list, createToken("BOOL",lines)); }
not                             {   insertOrderedList(&list, createToken("NOT",lines)); }
:=                              {   insertOrderedList(&list, createToken("ATRIB",lines)); }  
;                               {   insertOrderedList(&list, createToken("SCOL",lines)); }  
:                               {   insertOrderedList(&list, createToken("DOUBPO",lines)); }  
div                             {   insertOrderedList(&list, createToken("DIV",lines)); }  
","                             {   insertOrderedList(&list, createToken("COL",lines)); }  
"("                             {   insertOrderedList(&list, createToken("OPPAR",lines)); }
")"                             {   insertOrderedList(&list, createToken("CLPAR",lines)); }
"+"                             {   insertOrderedList(&list, createToken("PLUS",lines)); }  
"-"                             {   insertOrderedList(&list, createToken("MINUS",lines)); }  
"*"                             {   insertOrderedList(&list, createToken("MULT",lines)); }  
"."                             {   insertOrderedList(&list, createToken("POINT",lines)); }  
"="                             {   insertOrderedList(&list, createToken("EQUAL",lines)); }  
"<>"                            {   insertOrderedList(&list, createToken("DIF",lines)); }  
"=>"                            {   insertOrderedList(&list, createToken("LARGEREQ",lines)); }  
"=<"                            {   insertOrderedList(&list, createToken("SMALEREQ",lines)); }  
"<"                             {   insertOrderedList(&list, createToken("SMALER",lines)); }  
">"                             {   insertOrderedList(&list, createToken("LARGER",lines)); }  
{real}                          {   insertOrderedList(&list, createToken("NUMR",lines)); }
{natural}                       {   insertOrderedList(&list, createToken("NUMN",lines)); }
{integer}                       {   insertOrderedList(&list, createToken("NUMI",lines)); }
{id}                            {   insertOrderedList(&list, createToken("ID",lines)); } 
{id}[^(\n\t[:space:])]+         {   insertOrderedList(&list, createToken("IDERRO",lines)); errors++;} 
\n                              {   lines++; tabs=0; }
\t                              {   tabs++; }
[[:space:]]                     {}
[{][^}]*[}]                     { lines += contCaracter(yytext,'\n'); }  
.                               {  printf("%s aqq",yytext); insertOrderedList(&list, createToken("ERRO",lines)); errors++;}
%%

int main(int argc, char **argv)
{
    /* char *fileName;
    if( argc == 0)
        fileName = "teste1.s";
    else
        fileName = argv[0]; */
    FILE *file = fopen("../inputs/teste1.s", "r");


    if(!file){
        printf("Arquivo não encontrado");
        return -1;
    }

    yyin = file;

    yylex();
    
    printOrderedList(&list);
    if(errors)
        printf(
            "\n%d ERRO%sENCONTRADO%s\n",
            errors,
            errors==1? " ": "S ",
            errors==1? " ": "S "
        );
    fclose(file);
    destroyOrderedList(&list);
    
}