%{
#include <stdio.h>
#include "tinylang.h"
%}

integer   [-]?[0-9]+
float     [-]?[0-9]+[.][0-9]+
varname   [a-z][a-zA-Z]*
constname [A-Z][a-zA-Z]*
string    ["].*["]

%%

"exit"            { return EXIT; }
"print"           { return PRINT; }
"scan"            { return SCAN; }
"log"             { return LOG; }
"if"              { return IF; }
"elif"            { return ELSE_IF; }
"else"            { return ELSE; }
"while"           { return WHILE; }
"function"        { return FUNCTION; }
"passgen"         { return PASSGEN; }   /* takes a number, and creates password with that length*/
"passcheck"       { return PASSCHECK; } /* takes a string of password, and checks if it's strong */
"bicode"          { return BICODE; }    /* takes a string, and converts it to binary encoding space ( ) and dots (.) */
"bidecode"        { return BIDECODE; }  /* takes a string, and converts it from binary encoding space ( ) and dots (.) to normal */

";"               { return SEMICOLON; }
","               { return COMMA; }

"{"               { return LBRACE; }
"}"               { return RBRACE; }
"("               { return LPAREN; }
")"               { return RPAREN; }

"+"               { return ADD; }
"-"               { return SUB; }
"*"               { return MUL; }
"/"               { return DIV; }
"%"               { return MOD; }
"^"               { return POW; }
"~"               { return RANDOMPICK; } /* (2 ~ 3 # it may select two or three I don't know :) */

"="               { return ASSIGN; }

"?="              { return EQ; }
"!="              { return NOT_EQ; }
"/=/"             { return ALL_COMMON_DIV_EQ; }

"<"               { return LT; }
">"               { return GT; }
"<="              { return LE; }
">="              { return GE; }

"&&"              { return AND; }
"||"              { return OR; }
"^^"              { return XOR; }

{varname}         { return VARNAME; }
{constname}       { return CONSTNAME; }
{integer}         { return INTEGER; }
{float}           { return FLOAT; }
{string}          { return STRING; }

[ \t\r]+          { /* white space */ }
[\n]              { yylineno++; }

#.*\n             { /* comment */ }

%%

int yywrap() {
    return 1;
}