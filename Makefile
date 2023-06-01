CC=gcc
APP=calc

run: build
	./$(APP)

test: build
	./$(APP) < test.tinylang

build: lex.yy.c y.tab.c
	$(CC) -c y.tab.c lex.yy.c
	$(CC) -O3 lex.yy.o y.tab.o calc.c -o $(APP)

lex.yy.c: y.tab.c calc.l
	lex calc.l

y.tab.c: calc.y
	yacc -d calc.y

clean: 
	rm -rf lex.yy.c y.tab.c calc.dSYM lex.yy.o y.tab.o y.tab.h $(APP)