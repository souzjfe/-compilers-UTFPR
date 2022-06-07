
%{

#include <stdio.h>
extern int yyerror(char *message);
extern int yylex(void);

%}

%token  
  PROG      
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
  NUMR      
  NUMN      
  NUMI      
  ID        
  IDERRO    


%right  
  NOT

%left   
  MULTI
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
  ELSE
  ELSEIF

%right  
  ATRIB

%%

programa :      PROG identificador SCOL bloco {printf("Programa executado com sucesso!\n");}

bloco :         VAR declaracao START comandos END

declaracao :    nome_var DOUBPO tipo SCOL | 
                nome_var  DOUBPO tipo SCOL declaracao

nome_var :      identificador | 
                identificador COL nome_var

tipo :          INT | 
                FLOAT | 
                BOOL

comandos :      comando | 
                comando SCOL comandos

comando :       condicional |
                comando_combinado
                
comando_combinado :     IF expressao THEN comando_combinado ELSE comando_combinado |
                        atribuicao |  
                        enquanto | 
                        leitura | 
                        escrita 

atribuicao :    identificador ATRIB expressao

condicional :   IF expressao THEN comandos |
                IF expressao THEN comandos ELSE comandos

enquanto :      WHILE expressao DO comandos

leitura :       SCAN OPPAR  identificador CLPAR

escrita :       WHILE OPPAR  identificador CLPAR

expressao :     simples | 
                simples op_relacional simples

op_relacional : DIF | 
                EQUAL | 
                SMALER | 
                LARGER | 
                SMALEREQ | 
                LARGEREQ
simples :       termo operador termo | 
                termo
operador :      PLUS | 
                MINUS | 
                OR
termo :         fator | 
                fator op fator
op :            MULTI | 
                DIV | 
                AND
fator :         identificador | 
                numero | 
                OPPAR expressao CLPAR | 
                TRUE | 
                FALSE | 
                NOT fator
identificador : ID
numero :        NUMR |
                NUMN |
                NUMI

%%
