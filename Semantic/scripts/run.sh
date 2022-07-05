if [ ! -d "build" ]; then
mkdir build
fi

cd build
flex ../lib/scanner.l
bison -d ../lib/parser.y
gcc -c -o scanner.o lex.yy.c
gcc -c -o lista.o ../lib/Lista/lista.c
gcc -c -o parser.o parser.tab.c
gcc -c -o main.o ../lib/main.c
gcc -o main parser.o scanner.o main.o
./main $1

cd ..