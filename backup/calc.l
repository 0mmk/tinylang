%{
#include "y.tab.h"
void yyerror(char *s);
int yylex();
%}

%%

"print"         {return print;}
"scan"          {return scan;}
"exit"          {return exit_command;}
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