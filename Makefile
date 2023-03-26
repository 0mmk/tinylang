EXECUTABLE = scanner
SOURCE_FILES = scanner.c lex.yy.c
LEX_FILES = tinylang.l
LEX_OUTPUTS = lex.yy.c
LEXER = lex
CC = gcc
CFLAGS = -Wall

: run

run: build
	@./$(EXECUTABLE) < testinput.tinylang

build: lex compile

lex:
	@$(LEXER) $(LEX_FILES)

compile:
	@$(CC) -Wall $(CFLAGS) $(SOURCE_FILES) -o $(EXECUTABLE) 2>/dev/null

clean:
	rm -f $(EXECUTABLE) $(LEX_OUTPUTS) *.o