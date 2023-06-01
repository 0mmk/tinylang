%{
void yyerror (char *s);
int yylex();
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <math.h>
int symbols[52];
int symbolVal(char *symbol);
void updateSymbolVal(char *symbol, int val);
int power(int base, int exp);
void variables_dump();
%}

%union {
    int num;
    char *id;
}

%start prog
%token PRINT
%token PLUS MINUS EQUALS SEMICOLON MULTIPLY DIVIDE POWER LPARAN RPARAN EOL
%token EXIT_COMMAND DUMP_COMMAND
%token <num> number SCAN
%token <id> identifier
%type <num> exp term factor math_expr exponent numfunc numreturn
%type <id> setvariable

%%

prog    : lines

lines   : line finishes
        | lines line finishes
        ;

finishes : finish
         | finishes finish
         ;

finish : SEMICOLON
       | EOL
       ;

line    : setvariable                  {;}
        | voidfunc                     {;}
        | exp                          {printf(" // %d\n", $1);}
        ;

numfunc : SCAN LPARAN RPARAN           {int a; scanf("%d", &a); ; $$ = a;}

voidfunc : PRINT LPARAN exp RPARAN    {printf(" -> %d\n", $3);}
         | EXIT_COMMAND               {exit(EXIT_SUCCESS);}
         | DUMP_COMMAND               {variables_dump();}
         ;

setvariable : identifier EQUALS exp { updateSymbolVal($1, $3); }

exp     : math_expr
        ;

math_expr : factor                  
        | math_expr PLUS factor          {$$ = $1 + $3;}
        | math_expr MINUS factor          {$$ = $1 - $3;}
        ;

factor      : exponent
            | factor MULTIPLY exponent   {$$ = $1 * $3;}
            | factor DIVIDE exponent    {$$ = $1 / $3;}
            ;

exponent    : term                 {$$ = $1;}
            | term POWER exponent  {$$ = power($1, $3);}
            ;

term    : numreturn
        | LPARAN exp RPARAN     {$$ = $2;}
        ;

numreturn : number
        | identifier            {$$ = symbolVal($1);}
        | numfunc
        ;

%%

int power(int base, int exp) {
    return pow(base, exp);
}

int computeSymbolIndex(char *str) {
    char token = str[0];
    int idx = -1;

    if (islower(token))
        idx = token - 'a' + 26;
    else if (isupper(token))
        idx = token - 'A';

    return idx;
}

int symbolVal(char *symbol) {
    int bucket = computeSymbolIndex(symbol);
    return symbols[bucket];
}

void updateSymbolVal(char *symbol, int val) {
    int bucket = computeSymbolIndex(symbol);
    symbols[bucket] = val;
}

void variables_dump() {
    for (int i = 0; i < 52; i++) {
        if (symbols[i] != 0) {
            char c = 'A' + i;
            printf("%c = %d\n", c, symbols[i]);
        }
    }
}

int main(void) {
    for (int i = 0; i < 52; i++)
        symbols[i] = 0;
    return yyparse();
}

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}