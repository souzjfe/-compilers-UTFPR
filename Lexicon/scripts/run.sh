cd lib
flex index.l
gcc lex.yy.c -o executable -lfl
cd ..
./lib/executable $1
