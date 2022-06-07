
%{

#include <stdio.h>
extern int yyerror(char *message);
extern int yylex(void);
int linhas = 1;

%}

%token PROG      
  VAR       
  TRUE      
  FALSE     
  AND       
  OR        
  IF        
  ELSE
  THEN     
  WHILE     
  START    
  END       
  DO        
  SCAN      
  PUT       
  INT       
  FLOAT     
  BOOL      
  NOT       
  ATRIB     
  SCOL      
  DOUBPO    
  DIV       
  COL       
  OPPAR     
  CLPAR     
  PLUS      
  MINUS     
  MULT      
  POINT     
  EQUAL     
  DIF       
  LARGEREQ  
  SMALEREQ  
  SMALER    
  LARGERR    
  NUM     
  ID        
      


%right  
  NOT

%left   
  MULT
  DIV

%left   
  PLUS
  MINUS

%left   
  SMALER     
  LARGER     
  SMALEREQ
  LARGEREQ

%left   
  EQUAL
  DIF

%right  
  ATRIB

%%

programa :      PROG identificador SCOL bloco {printf("<programa> ::= programa <identificador> ; <bloco>\n");}

bloco :         VAR declaracao START comandos END {printf("<bloco> ::= var <declaracao> inicio <comandos> fim\n");}

declaracao :    nome_var DOUBPO tipo SCOL {printf("<declaracao> ::= <nome_var> : <tipo> ;\n");}
                | nome_var  DOUBPO tipo SCOL declaracao {printf("<declaracao> ::= <nome_var> : <tipo> ; <declaracao>\n");}

nome_var :      identificador {printf("<nome_var> ::= <identificador>\n");}
                | identificador COL nome_var {printf("<nome_var> ::= <identificador> , <nome_var>\n");}

tipo :          INT {printf("<tipo> ::= int\n");}
                | FLOAT {printf("<tipo> ::= float\n");}
                | BOOL {printf("<tipo> ::= bool\n");}

comandos :      comando {printf("<comandos> ::= <comando>\n");} 
                | comando SCOL comandos {printf("<comandos> ::= <comando> ; <comandos>\n");}

comando :       comando_combinado {printf("<comando> ::= <comando_combinado>\n");}
                | condicional {printf("<comando> ::= <condicional>\n");}
                

comando_combinado :     IF expressao THEN comando_combinado ELSE comando_combinado {printf("<comando_combinado> ::= if <expressao> then <comando_combinado> else <comando_combinado>\n");}
                        | atribuicao {printf("<comando_combinado> ::= <atribuicao>\n");} 
                        | enquanto {printf("<comando_combinado> ::= <enquanto>\n");}
                        | leitura {printf("<comando_combinado> ::= <leitura>\n");}
                        | escrita {printf("<comando_combinado> ::= <escrita>\n");}

atribuicao :    identificador ATRIB expressao {printf("<atribuicao> ::= <identificador> = <expressao>\n");}

condicional :   IF expressao THEN comando {printf("<condicional> ::= se <expressao> entao <comando>\n");}
                | IF expressao THEN comando_combinado ELSE condicional {printf("<condicional> ::= se <expressao> entao <comando_combinado> senao <condicional>\n");}

enquanto :      WHILE expressao DO comando_combinado {printf("<enquanto> ::= enquanto <expressao> faca <comando_combinado>\n");}

leitura :       SCAN OPPAR  identificador CLPAR {printf("<leitura> ::= leia ( <identificador> )\n");}

escrita :       PUT OPPAR  identificador CLPAR {printf("<escrita> ::= escreva ( <identificador> )\n");}

expressao :     simples {printf("<expressao> ::= <simples>\n");}
                | simples op_relacional simples {printf("<expressao> ::= <simples> <op_relacional> <simples>\n");}

op_relacional : DIF {printf("<op_relacional> ::= <>\n");}
                | EQUAL {printf("<op_relacional> ::= =\n");}
                | SMALER {printf("<op_relacional> ::= <\n");}
                | LARGER {printf("<op_relacional> ::= >\n");}
                | SMALEREQ {printf("<op_relacional> ::= <=\n");}
                | LARGEREQ {printf("<op_relacional> ::= >=\n");}

simples :       termo operador termo {printf("<simples> ::= <termo> <operador> <termo>\n");}
                | termo {printf("<simples> ::= <termo>\n");}
                
operador :      PLUS {printf("<operador> ::= +\n");}
                | MINUS {printf("<operador> ::= -\n");}
                | OR {printf("<operador> ::= ou\n");}

termo :         fator {printf("<termo> ::= <fator>\n");}
                | fator op fator {printf("<termo> ::= <fator> <op> <fator>\n");}

op :            MULT {printf("<op> ::= *\n");}
                | DIV {printf("<op> ::= div\n");}
                | AND {printf("<op> ::= e\n");}

fator :         identificador {printf("<fator> ::= <identificador>\n");} 
                | numero {printf("<fator> ::= <numero>\n");}
                | OPPAR expressao CLPAR {printf("<fator> ::= ( <expressao> )\n");}
                | TRUE {printf("<fator> ::= true\n");}
                | FALSE {printf("<fator> ::= false\n");}
                | NOT fator {printf("<fator> ::= not <fator>\n");}

identificador : ID {printf("<identificador> ::= <ID>\n");}

numero :        NUM {printf("<numero> ::= <NUM>\n");}

%%
