#ifndef OrderedList_h
#define OrderedList_h

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "../Token/Token.h"
//---------------------------------------------------------------------------------
// Types
//---------------------------------------------------------------------------------

typedef struct NodeList *PtrNodeList;

typedef struct NodeList {
  Token x;
  PtrNodeList next;
} NodeList;

typedef struct {
  PtrNodeList first;
  int size;
} OrderedList;

//---------------------------------------------------------------------------------
// Functions
//---------------------------------------------------------------------------------

void initOrderedList(OrderedList *list);
void insertOrderedList(OrderedList *list, Token x);
void printOrderedList(OrderedList *list);
void destroyOrderedList(OrderedList *list);
bool isEmptyOrderedList(OrderedList *list);
bool searchOrderedList(OrderedList *list, Token x);
bool searchFasterOrderedList(OrderedList *list, Token x);
int sizeOfOrderedList(OrderedList *list);
void removeOrderedList(OrderedList *list, int key, int *x);
void removeFirstOrderedList(OrderedList *list, int *x);
void removeLastOrderedList(OrderedList *list, int *x);
int firstOrderedList(OrderedList *list);
int lastOrderedList(OrderedList *list);

#endif /* OrderedList_h */