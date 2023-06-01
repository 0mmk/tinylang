%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include "calc.h"

Node* createOperator(int oper, int nops, ...);
Node* createIdentifier(int i);
Node* createConstant(int value);
Node* createString(char* s);
void freeNode(Node* p);
int evaluate(Node* p);
int yylex(void);
void yyerror(char* s);
int sym[256];

%}

%union {
  int num;
  char sPos;
  Node* nPtr;
  char *strin;
};

%token <num> INTEGER
%token <strin> STRING
%token <sPos> VARIABLE
%token WHILE IF PRINT FNDEF FNCALL LPAREN RPAREN LT GT ADD MUL SET EQ NEQ SUB DIV COMB
%type <nPtr> prog expr math comb

%%

start:
  prog   { evaluate($1); freeNode($1); } start
  | expr { evaluate($1); freeNode($1); } start
  |
  ;

prog: 
  LPAREN comb RPAREN                  { $$ = $2; }
  | LPAREN PRINT expr RPAREN          { $$ = createOperator(PRINT, 1, $3); }
  | LPAREN PRINT STRING RPAREN        { $$ = createOperator(PRINT, 1, createString($3)); }
  | LPAREN SET VARIABLE expr RPAREN   { $$ = createOperator(SET, 2, createIdentifier($3), $4); }
  | LPAREN WHILE expr prog RPAREN     { $$ = createOperator(WHILE, 2, $3, $4); }
  | LPAREN IF expr prog RPAREN        { $$ = createOperator(IF, 2, $3, $4); }
  | LPAREN FNDEF VARIABLE prog RPAREN { $$ = createOperator(FNDEF, 2, createIdentifier($3), $4); }
  | LPAREN FNCALL VARIABLE RPAREN     { $$ = createOperator(FNCALL, 1, createIdentifier($3)); }
  ;

comb:
  comb prog { $$ = createOperator(COMB, 2, $1, $2); }
  | prog    { $$ = $1; }
  ;

expr:
  INTEGER              { $$ = createConstant($1); }
  | VARIABLE           { $$ = createIdentifier($1); }
  | LPAREN math RPAREN { $$ = $2; }
  ;

math:
  ADD expr expr   { $$ = createOperator(ADD, 2, $2, $3); }
  | MUL expr expr { $$ = createOperator(MUL, 2, $2, $3); }
  | SUB expr expr { $$ = createOperator(SUB, 2, $2, $3); }
  | DIV expr expr { $$ = createOperator(DIV, 2, $2, $3); }
  | LT expr expr  { $$ = createOperator(LT, 2, $2, $3); }
  | GT expr expr  { $$ = createOperator(GT, 2, $2, $3); }
  | EQ expr expr  { $$ = createOperator(EQ, 2, $2, $3); }
  | NEQ expr expr { $$ = createOperator(NEQ, 2, $2, $3); }
  ;

%%

Node* createString(char* s) {
  Node* p = malloc(sizeof(Node));
  p->type = typeStr;
  s[strlen(s) - 2] = '\0';
  p->snode.str = s + 1;

  return p;
}

Node* createConstant(int value) {
  Node* p = malloc(sizeof(Node));
  p->type = typeCon;
  p->con.value = value;

  return p;
}

Node* createIdentifier(int i) {
  Node* p = malloc(sizeof(Node));
  p->type = typeId;
  p->id.i = i;

  return p;
}

Node* createOperator(int oper, int nops, ...) {
  va_list ap;
  Node* p = malloc(sizeof(Node) + (nops - 1) * sizeof(Node*));
  p->type = typeOpr;
  p->opr.oper = oper;
  p->opr.nops = nops;

  va_start(ap, nops);
  for (int i = 0; i < nops; i++)
    p->opr.op[i] = va_arg(ap, Node*);
  va_end(ap);

  return p;
}

void freeNode(Node* p) {
  if (!p)
    return;

  if (p->type == typeOpr)
    for (int i = 0; i < p->opr.nops; i++)
      freeNode(p->opr.op[i]);

  free(p);
}

void yyerror(char* s) {
  extern char* yytext;
  extern int yylineno;
  fprintf(stdout, "%s\nLine No: %d\nAt char: %c\n", s, yylineno, *yytext);
}

int main(void) {
  yyparse();
  return 0;
}
