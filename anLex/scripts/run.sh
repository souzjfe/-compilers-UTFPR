cd lib
flex index.l
gcc lex.yy.c Token/Token.c OrderedList/OrderedList.c Utils/Utils.c -o output -lfl
./output
cd ..