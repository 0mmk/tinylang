%{
#include "y.tab.h"
void yyerror(char *s);
int yylex();
%}

%%

"print"         return PRINT;
"scan"          return SCAN;
"dump"          return DUMP_COMMAND;
"exit"          return EXIT_COMMAND;
[a-zA-Z]+       {yylval.id = yytext; return identifier;}
[0-9]+          {yylval.num = atoi(yytext); return number;}
[ \t]           ;
"+"             return PLUS;
"-"             return MINUS;
"*"             return MULTIPLY;
"/"             return DIVIDE;
"**"            return POWER;
"="             return EQUALS;
";"             return SEMICOLON;
"("             return LPARAN;
")"             return RPARAN;
"\n"            return EOL;
.               {ECHO; yyerror("Unexpected Character!");}

%%

int yywrap(void) {
    return 1;
}