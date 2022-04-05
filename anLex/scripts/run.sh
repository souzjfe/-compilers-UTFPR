flex wc.l
gcc lex.yy.c Token.c OrderedList.c Utils.c -o output -lfl
./output