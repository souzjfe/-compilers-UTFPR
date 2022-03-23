//---------------------------------------------------------------------------------
//---------------------------------------------------------------------------------

#include <stdio.h>
#include "OrderedList.h"
#include "Token.h"
//---------------------------------------------------------------------------------
//---------------------------------------------------------------------------------

int main(int argc, const char * argv[]) {

    OrderedList *list;

    initOrderedList(list);

    if(isEmptyOrderedList(&list)) {
        printf("The ordered list is empty\n");
    }

    printf("\n---------------------------\n");
    printf(" *** Testing: inserting elements \n");
    printf("---------------------------\n");
    Token tal;
    tal.pos=1;
    tal.name="ATRB";
    insertOrderedList(&list,createToken("PRROG",2));
    printOrderedList(&list);
    insertOrderedList(&list,tal);
    printOrderedList(&list);
    insertOrderedList(&list,tal);
    printOrderedList(&list);
  

  return 0;
}