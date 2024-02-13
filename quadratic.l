%{
/* This scanner recognises the variables, numbers and operators in the formula:
 * x = (-b ± sqrt(b ^ 2 - 4 * a * c) / (2 * a))
 */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
%}

digit       [0-9]
number      {digit}+(\.{digit}+)?
operator    [\+\-\*/"±"=\^]
whitesp     [ \t\n]        

%%
{whitesp}+  ; // ignore whitespace
{number}    { printf("number: %s\n", yytext); }
{operator}  { printf("operator: %s\n", yytext); }
"("         { printf("left paren\n"); }
")"         { printf("right paren\n"); }
"x"         { printf("variable: x\n"); }
"a"         { printf("variable: a\n"); }
"b"         { printf("variable: b\n"); }
"c"         { printf("variable: c\n"); }
"sqrt"      { printf("fn: square root\n"); }
.           { fprintf(stderr, "unknown char: %s\n", yytext); }
%%

int main()
{
    yylex();
    return 0;
}
