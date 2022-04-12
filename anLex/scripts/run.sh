cd lib
flex index.l
gcc lex.yy.c Token/Token.c OrderedList/OrderedList.c Utils/Utils.c -o executable -lfl
./executable
cd ..