/* flex wc.l && gcc lex.yy.c Token.c OrderedList.c -o jfe -lfl*/
%option noyywrap
%option header-file="lex.yy.h"


%{
#include "../build/parser.tab.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
extern YYSTYPE yylval;



%}

id [[:alpha:]_][[:alnum:]_]*
natural [0-9]+
integer "-"?{natural}
real    {integer}"."{natural}

%%
                

programa    	                  {   return PROG       ;}
var                             {   return VAR        ;}
verdadeiro                      {   return TRUE       ;}
falso                           {   return FALSE      ;}
e                               {   return AND        ;}
ou                              {   return OR         ;}
se                              {   return IF         ;}
senao                           {   return ELSE       ;}
entao                           {   return THEN       ;}
enquanto                        {   return WHILE      ;}
inicio                          {   return START      ;}
fim                             {   return END        ;}
faca                            {   return DO         ;}
leia                            {   return SCAN       ;}
escreva                         {   return PUT        ;}
inteiro                         {   return INT        ;}
real                            {   return FLOAT      ;}
boleano                         {   return BOOL       ;}
nao                             {   return NOT        ;}
:=                              {   return ATRIB      ;}
;                               {   return SCOL       ;}
:                               {   return DOUBPO     ;}
","                             {   return COL        ;}
"("                             {   return OPPAR      ;}
")"                             {   return CLPAR      ;}
div                             {   yylval.lex_value = strdup(yytext); return DIV        ;}
"+"                             {   yylval.lex_value = strdup(yytext); return PLUS       ;}
"-"                             {   yylval.lex_value = strdup(yytext); return MINUS      ;}
"*"                             {   yylval.lex_value = strdup(yytext); return MULT       ;}
"."                             {   return POINT      ;}
"="                             {   return EQUAL      ;}
"<>"                            {   return DIF        ;}
">="                            {   return LARGEREQ   ;}
"<="                            {   return SMALEREQ   ;}
"<"                             {   return SMALER     ;}
">"                             {   return LARGER     ;}
{integer}                       {   yylval.value = atoi(yytext); return NUM    ;}
{real}                          {   return NUM        ;}
{natural}                       {   return NUM        ;}
{id}                            {   yylval.lex_value = strdup(yytext); return ID         ;}
{id}[^(\n\t[:space:])]+         {  printf("\nError: lexical error"); }
\n                              {  }
\t                              {  }
[[:space:]]                     {  }
[{][^}]*[}]                     {  }  
.                               {  }                                     
%%

