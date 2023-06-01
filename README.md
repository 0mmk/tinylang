[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/8SemUSNK)
[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-718a45dd9cf7e7f842a935f5ebbe5719a5e09af4491e668f4dbf3b35d5cca122.svg)](https://classroom.github.com/online_ide?assignment_repo_id=11228872&assignment_repo_type=AssignmentRepo)
# TinyLang

A tiny programming language that is inspired by Lisp with very minimal binary form that doesn't make things complicated overtime - function definitions and calls. :))

Developer: Mehmet Melih Karakaya <20190808067>

## Running instructions:

> make

## Running tests

> make test

## Syntax Explanation
Syntax explanation and examples are given in test.tinylang file as well
* Has `if` for conditional execution
* Variable assigment and declaration
* Has function definitions and calls
  * but that would require complex yacc with AST :(
    * Yay! Done. However I had to remove some complexity of my language.
* Blocks for statements like while, if, functions...
* Integer declaration without requireing a keyword for assignments.


## Design Decisions
* I didn't wanted to make this programming language really complex bcs I had ran into this issue before, an overly complicated syntax, making it harder for one person to manage and understand the behavior of semantics.
  * I didn't take PL Class before but had interest in this area, see: https://github.com/0mmk/calc
    * (it's not a programming language, it's a really bad calc that I made in my first year at Uni), so I was familiar with lexers and other tools bcs I understood my calc sucks. But I wasn't completely dived into lexers, now I'm.
  * However I wish I knew lex/yacc or other tools preferably so good that I can create a PL that proofs memory safety just like Rust.
* In fact, I've removed some of the complex stuff from my older version attempts in order to write a "properly working" language interpreter.

<details>
  <summary>Click to see the explanation</summary>
  ### Note: Because the language is inspired by Lisp, I've used lisp syntax highlighting for better readability.

  ```lisp
  // comment

  // printing string
  (print "----------------------------")
  (print "Every string is a multiline string

  Line 1
  Line 2
  Line 3")
  (print "----------------------------")

  (print "Assigning Variable 'x': 5, 10, 50")

  // variable assignment
  (= x 5) // becomes 1

  // variable assignment #2
  (= x (+ x 5)) // becomes 10

  // variable assignment #3
  (= x (* 10 5)) // becomes 50

  // printing variables/numbers
  (print x)
  (print "Printing literal int constant 3: ")
  (print 3)

  (print "----------------------------")

  (print "Printing complex expression 2 + 5 / 2 * 3")

  // complex expression 2 + 5 / 2 * 3
  (print (+ 2 (* (/ 5 2) 3)))

  (print "----------------------------")

  // while loop printing from 50 to 1
  (print "Printing numbers from 50 to 1: ")

  (while (!= x 0)
    (
      (print x)
      (= x (- x 1))
    )
  )

  (= x 0)
  // while loop, dummy iteration 100000 times
  (while (!= x 100000)
    (= x (+ x 1))
  )

  // if statement, insider block won't execute
  (= x 10)
  (if (> x 10) 
    (
      (print "This will not execute!
      This will not be seen!
      This will not exist!")
    )
  )

  (print "----------------")

  // if statment, insider block will execute
  (if (?= x 10) (print "This will be seen!"))

  (print "----------------")
  (print "Printing numbers to show combined statements")
  // combined statements
  // functions like if, while, def and only takes one argument for execution, which is block
  (if (< x 100)
    (print x)
  )
  // however a block can have multiple blocks inside of it, for example
  (if (< x 100) (
      (print x)
      (print x)
    )
  )


  // function definition with loop, assigments and operations
  (def f (
      (while (> n 0) (
          (= a b)
          (= b c)
          (= c (+ a b))
          (= n (- n 1))
        )
      )
      (print a)
    )
  )

  // function definition (recursive)
  (def r (
      (if (?= n 0) (print a))
      (if (!= n 0) (
          (= a b)
          (= b c)
          (= c (+ a b))
          (= n (- n 1))
          (call r)
        )
      )
    )
  )

  (print "----------------------------")

  // function call
  // it doesn't matter if it's one line or many lines
  (print "Fibonacci(12) Imperative: ")
  (= n 12) (= a 0) (= b 1) (= c 1)
  (call f)

  // function call
  (print "Fibonacci(12) Recursive:  ")
  (= n 12) (= a 0) (= b 1) (= c 1)
  (call r)

  (print "----------------------------")
  ```

</details>

<details>
  <summary>Click to see the output</summary>

  ```
  ----------------------------
  Every string is a multiline string

  Line 1
  Line 2
  Line 3
  ----------------------------
  Assigning Variable 'x': 5, 10, 50
  50
  Printing literal int constant 3: 
  3
  ----------------------------
  Printing complex expression 2 + 5 / 2 * 3
  8
  ----------------------------
  Printing numbers from 50 to 1: 
  50
  49
  48
  47
  46
  45
  44
  43
  42
  41
  40
  39
  38
  37
  36
  35
  34
  33
  32
  31
  30
  29
  28
  27
  26
  25
  24
  23
  22
  21
  20
  19
  18
  17
  16
  15
  14
  13
  12
  11
  10
  9
  8
  7
  6
  5
  4
  3
  2
  1
  ----------------
  This will be seen!
  ----------------
  Printing numbers to show combined statements
  10
  10
  10
  ----------------------------
  Fibonacci(12) Imperative: 
  144
  Fibonacci(12) Recursive:  
  144
  ----------------------------
  ```

</details>

## Design Decisions


## BNF Form

```bnf
<start> : <prog> <start>
          | <expr> <start>
          | 
          ;

<prog>  : '(' <comb> ')'
          | '(' 'print' <expr> ')'
          | '(' 'print' <string> ')'
          | '(' '=' <variable> <expr> ')'
          | '(' 'while' <expr> <prog> ')'
          | '(' 'if' <expr> <prog> ')'
          | '(' 'def' <variable> <prog> ')'
          | '(' 'call' <variable> ')'
          ;

<comb>  : <comb> <prog>
          | <prog>
          ;

<expr>  : <string>
          | <variable>
          | '(' <math> ')'
          ;

<math>  : '+' <expr> <expr>
          | '*' <expr> <expr>
          | '-' <expr> <expr>
          | '/' <expr> <expr>
          | '<' <expr> <expr>
          | '>' <expr> <expr>
          | '?=' <expr> <expr>
          | '!=' <expr> <expr>
          ;

<integer> : [0-9]+
<variable> : [a-zA-Z]+
<string> : ".*"

```
