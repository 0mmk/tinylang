#include <stdio.h>
#include <stdlib.h>

#include "tinylang.h"

const char *mykeywords[] = {
    0,
    "EXIT",
    "PRINT",
    "SCAN",
    "LOG",
    "IF",
    "ELSE_IF",
    "ELSE",
    "WHILE",
    "FUNCTION",
    "PASSGEN",
    "PASSCHECK",
    "BICODE",
    "BIDECODE",
    "SEMICOLON",
    "COMMA",
    "LBRACE",
    "RBRACE",
    "LPAREN",
    "RPAREN",
    "ADD",
    "SUB",
    "MUL",
    "DIV",
    "MOD",
    "POW",
    "RANDOMPICK",
    "ASSIGN",
    "EQ",
    "NOT_EQ",
    "ALL_COMMON_DIV_EQ",
    "LT",
    "GT",
    "LE",
    "GE",
    "AND",
    "OR",
    "XOR",
    "VARNAME",
    "CONSTNAME",
    "INTEGER",
    "FLOAT",
    "STRING",
};

extern int yylex();
extern int yylineno;
extern char *yytext;

int main() {
    int ntoken;
    int lineno = yylineno;
    while ((ntoken = yylex())) {
        if (yylineno != lineno) {
            lineno = yylineno;
            printf("\n");
        }
        printf("%s ", mykeywords[ntoken]);
    }
    printf("\n");
    return 0;
}