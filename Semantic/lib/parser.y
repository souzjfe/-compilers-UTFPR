
%{

#include <stdio.h>
#include <string.h>
#include "../lib/Lista/lista.c"
extern int yyerror(char *message);
extern int yylex(void);
int linhas = 1;
LISTA *lista;
%}

%union{
  int value;
  char* lex_value;
}
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

%type <value> numero fator termo simples expressao identificador
%start S

%%

S :      PROG identificador SCOL bloco {clearLISTA(lista);}

bloco :         VAR declaracao START comandos END {}

declaracao :    nome_var DOUBPO tipo SCOL {}
                | nome_var  DOUBPO tipo SCOL declaracao {}

nome_var :      identificador {}
                | identificador COL nome_var {}

tipo :          INT {}
                | FLOAT {}
                | BOOL {}

comandos :      comando {} 
                | comando SCOL comandos {}

comando :       comando_combinado {}
                | condicional {}
                

comando_combinado :     IF expressao THEN comando_combinado ELSE comando_combinado {}
                        | atribuicao {} 
                        | enquanto {}
                        | leitura {}
                        | escrita {}

atribuicao :    identificador ATRIB expressao {if(isEmpty(lista)){
        lista = createLISTA();
  } insertNODE(lista, $<lex_value>1, $<value>3);
}

condicional :   IF expressao THEN comando {}
                | IF expressao THEN comando_combinado ELSE condicional {}

enquanto :      WHILE expressao DO comando_combinado {}

leitura :       SCAN OPPAR  identificador CLPAR {}

escrita :       PUT OPPAR  identificador CLPAR { printf("%d\n", getValue(lista, $<lex_value>3));}

expressao :     simples { }
                | simples op_relacional simples { $<value>$ = $<value>1;}

op_relacional : DIF {}
                | EQUAL {}
                | SMALER {}
                | LARGER {}
                | SMALEREQ {}
                | LARGEREQ {}

simples :       termo operador termo {
                  if(strcmp($<lex_value>2, "+") == 0){
                          $<value>$ = $<value>1 + $<value>3;
                  }else if(strcmp($<lex_value>2, "-") == 0){
                          $<value>$ = $<value>1 - $<value>3;
                  }
                }
                | termo { $<value>$ = $<value>1;}
                
operador :      PLUS {}
                | MINUS {}
                | OR {}

termo :         fator {$<value>$ = $<value>1;}
                | fator op fator {
                  if(strcmp($<lex_value>2, "*") == 0){
                        $<value>$ = $<value>1 * $<value>3;
                  }else if(strcmp($<lex_value>2 , "DIV") == 0){
                        $<value>$ = $<value>1 / $<value>3;
                  }
                }

op :            MULT {}
                | DIV {}
                | AND {}

fator :         identificador { $<value>$ = getValue(lista, $<lex_value>1);} 
                | numero {  $<value>$ = $<value>1;}
                | OPPAR expressao CLPAR {$<value>$ = $<value>2;}
                | TRUE {}
                | FALSE {}
                | NOT fator {}

identificador : ID {}

numero :        NUM {$<value>$ = $<value>1;}

%%
