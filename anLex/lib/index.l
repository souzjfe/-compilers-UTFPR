/* flex wc.l && gcc lex.yy.c Token.c OrderedList.c -o jfe -lfl*/
%option noyywrap

%{
#define RED      "\x1b[31m" 
#define GRAY     "\e[0;37m"
#define GREEN     "\e[0;32m"
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
programa    	                {   insertOrderedListAndPrintToken(&list, createToken("PROG",lines)); }  
var                             {   insertOrderedListAndPrintToken(&list, createToken("VAR",lines)); }  
verdadeiro                      {   insertOrderedListAndPrintToken(&list, createToken("TRUE",lines)); }  
falso                           {   insertOrderedListAndPrintToken(&list, createToken("FALSE",lines)); }  
e                               {   insertOrderedListAndPrintToken(&list, createToken("AND",lines)); }  
ou                              {   insertOrderedListAndPrintToken(&list, createToken("OU",lines)); }  
se                              {   insertOrderedListAndPrintToken(&list, createToken("IF",lines)); }  
senao                           {   insertOrderedListAndPrintToken(&list, createToken("IF",lines)); }  
enquanto                        {   insertOrderedListAndPrintToken(&list, createToken("WHILE",lines)); }  
inicio                          {   insertOrderedListAndPrintToken(&list, createToken("BEGIN",lines)); }
fim                             {   insertOrderedListAndPrintToken(&list, createToken("END",lines)); }  
faca                            {   insertOrderedListAndPrintToken(&list, createToken("DO",lines)); }
leia                            {   insertOrderedListAndPrintToken(&list, createToken("SCAN",lines)); }
escreva                         {   insertOrderedListAndPrintToken(&list, createToken("PUT",lines)); }
inteiro                         {   insertOrderedListAndPrintToken(&list, createToken("INT",lines)); }
real                            {   insertOrderedListAndPrintToken(&list, createToken("FLOAT",lines)); }
booleano                        {   insertOrderedListAndPrintToken(&list, createToken("BOOL",lines)); }
not                             {   insertOrderedListAndPrintToken(&list, createToken("NOT",lines)); }
:=                              {   insertOrderedListAndPrintToken(&list, createToken("ATRIB",lines)); }  
;                               {   insertOrderedListAndPrintToken(&list, createToken("SCOL",lines)); }  
:                               {   insertOrderedListAndPrintToken(&list, createToken("DOUBPO",lines)); }  
div                             {   insertOrderedListAndPrintToken(&list, createToken("DIV",lines)); }  
","                             {   insertOrderedListAndPrintToken(&list, createToken("COL",lines)); }  
"("                             {   insertOrderedListAndPrintToken(&list, createToken("OPPAR",lines)); }
")"                             {   insertOrderedListAndPrintToken(&list, createToken("CLPAR",lines)); }
"+"                             {   insertOrderedListAndPrintToken(&list, createToken("PLUS",lines)); }  
"-"                             {   insertOrderedListAndPrintToken(&list, createToken("MINUS",lines)); }  
"*"                             {   insertOrderedListAndPrintToken(&list, createToken("MULT",lines)); }  
"."                             {   insertOrderedListAndPrintToken(&list, createToken("POINT",lines)); }  
"="                             {   insertOrderedListAndPrintToken(&list, createToken("EQUAL",lines)); }  
"<>"                            {   insertOrderedListAndPrintToken(&list, createToken("DIF",lines)); }  
"=>"                            {   insertOrderedListAndPrintToken(&list, createToken("LARGEREQ",lines)); }  
"=<"                            {   insertOrderedListAndPrintToken(&list, createToken("SMALEREQ",lines)); }  
"<"                             {   insertOrderedListAndPrintToken(&list, createToken("SMALER",lines)); }  
">"                             {   insertOrderedListAndPrintToken(&list, createToken("LARGER",lines)); }  
{real}                          {   insertOrderedListAndPrintToken(&list, createToken("NUMR",lines)); }
{natural}                       {   insertOrderedListAndPrintToken(&list, createToken("NUMN",lines)); }
{integer}                       {   insertOrderedListAndPrintToken(&list, createToken("NUMI",lines)); }
{id}                            {   insertOrderedListAndPrintToken(&list, createToken("ID",lines)); } 
{id}[^(\n\t[:space:])]+         {   insertOrderedListAndPrintToken(&list, createToken("IDERRO",lines)); errors++;} 
\n                              {   printf("\n"); lines++; tabs=0; }
\t                              {   printf("\t"); tabs++; }
[[:space:]]                     {   printf(" "); }
[{][^}]*[}]                     {   lines += contCaracter(yytext,'\n'); }  
.                               {  printf(RED "%s aqq",yytext); insertOrderedList(&list, createToken("ERRO",lines)); errors++;}
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
    
    
    if(errors)
        printf(
            RED "\n%d ERRO%sENCONTRADO%s\n",
            errors,
            errors==1? " ": "S ",
            errors==1? " ": "S "
        );
    fclose(file);
    destroyOrderedList(&list);
    
}