# TINYLANG

## A tiny programming language that has predefined functions for easily generating passwords, hiding text in binary format; operators that can pick between variables and compare two numbers for their common divisors. :))

Developer: Mehmet Melih Karakaya <20190808067>


Compile and run
```sh
make
```

`make [build|run|clean]`: other options

BNF
```bnf
<program> ::= <stat-list>

<stat-list> ::= <stat> | <stat> <stat-list>

<stat> ::= <expr> SEMICOLON
        | <assigning> SEMICOLON
        | <predef-fn-calls> SEMICOLON
        | <if-stat>
        | <while-stat>
        | <fn-def>

<predef-fn-call> ::= EXIT
             | SCAN
             | PRINT <expr>
             | LOG <expr>
             | PASSGEN <expr>
             | PASSCHECK <expr>
             | BICODE <expr>
             | BIDECODE <expr>

<if-stat> ::= IF LPAREN <cond> RPAREN LBRACE <stat-list> RBRACE
            | IF LPAREN <cond> RPAREN LBRACE <stat-list> RBRACE <elif-stat>
            | IF LPAREN <cond> RPAREN LBRACE <stat-list> RBRACE ELSE LBRACE <stat-list> RBRACE

<elif-stat> ::= ELIF LPAREN <cond> RPAREN LBRACE <stat-list> RBRACE
              | ELIF LPAREN <cond> RPAREN LBRACE <stat-list> RBRACE <elif-stat>
              | ELIF LPAREN <cond> RPAREN LBRACE <stat-list> RBRACE ELSE LBRACE <stat-list> RBRACE

<while-stat> ::= WHILE LPAREN <cond> RPAREN LBRACE <stat-list> RBRACE

<fn-def> ::= FUNCTION <vars> LPAREN <params> RPAREN LBRACE <stat-list> RBRACE

<params> ::= <params> | <params> COMMA <params>

<cond> ::= <expr> <comp-ops> <expr>

<comp-ops> ::= EQ | NOT_EQ | ALL_COMMON_DIV_EQ | LT | GT | LE | GE

<low-math-ops> ::= ADD | SUB
<expr> ::= <term> | <term> <low-math-ops> <expr>

<high-math-ops> ::= MUL | DIV | MOD | POW
<term> ::= <factor> | <factor> <high-math-ops> <term>

<vars> ::= VARNAME | CONSTNAME

<factor> ::= <vars>
          | LPAREN <expr> RPAREN
          | <factor> RANDOMPICK <factor>
          | <fn-call>

<fn-call> ::= <vars> LPAREN <args> RPAREN | <predef-fn-call>

<args> ::= <expr> | <expr> COMMA <args>

<logical-ops> ::= AND | OR | XOR

<logical-expr> ::= <cond> <logical-ops> <cond>
                | LPAREN <logical-expr> RPAREN

<assigning> ::= <vars> ASSIGN <exprs>
```

## Iterations
There's a folder named backup, in there you'll see a programming language I tried to create with lex/yacc so that I could understand this topic better. Although the iterations are not part of my homework, the yacc file in the `backup` folder can demonstrate my work for learning.

## Explanation
* Has `if`, `elif`, `else` for conditional execution
* Variable assigment and declaration
  * to make a const variable, just make it's first letter uppercase.
* Has predefined functions for ease of use
  * print, scan, log, bicode, bidecode, passgen, passcheck, exit.
* Has function definitions and calls
  * but that would require complex yacc with AST :(
* Blocks for statements like while, if, functions...
* Strings, integers and floats without requireing a keyword for assignments.
* 


## Design Decisions
* I didn't wanted to make this programming language really complex bcs I had ran into this issue before, an overly complicated syntax, making it harder for one person to manage and understand the behavior of semantics.
  * I didn't take PL Class before but had interest in this area, see: https://github.com/0mmk/calc
    * (it's not a programming language, it's a really bad calc that I made in my first year at Uni), so I was familiar with lexers and other tools bcs I understood my calc sucks. But I wasn't completely dived into lexers, now I'm.
  * However I wish I knew lex/yacc or other tools preferably so good that I can create a PL that proofs memory safety just like Rust.