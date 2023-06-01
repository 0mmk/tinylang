%{
#include <stdlib.h>
#include "calc.h"
#include "y.tab.h"
void yyerror(char *);
%}

%%

"while"         return WHILE;
"if"            return IF;
"print"         return PRINT;
"def"           return FNDEF;
"call"          return FNCALL;

"+"             { return ADD; }
"*"             { return MUL; }
"-"             { return SUB; }
"/"             { return DIV; }
"="             { return SET; }
"?="            { return EQ; }
"!="            { return NEQ; }

"<"             { return LT; }
">"             { return GT; }

"("             { return LPAREN; }
")"             { return RPAREN; }
[a-zA-Z]+       { yylval.sPos = yytext[0]; return VARIABLE;}
[0-9]+          { yylval.num = atoi(yytext); return INTEGER; }
"//".*          ; /* ignore comments */

"\""[^"]*"\"" { yylval.strin = yytext; return STRING; }

[ \t\n]+        ; /* ignore whitespace */

.               yyerror("Unknown character");
%%
int yywrap(void) {
    return 1;
}


/* (def f (
 (= x (+ x 1))
 (print x)
 (if (< x 10) (call f))
 (if (?= x 10) (= x 0))
)) */