%{
/* This scanner recognises the variables, numbers and operators in the formula:
 * K = sqrt(s * (s - a) * (s - b) * (s - c) * (s - d))
 */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
%}

digit       [0-9]
number      {digit}+(\.{digit}+)?
operator    [\-\*=]
whitesp     [ \t\n]        

%%
{whitesp}+  ; // ignore whitespace
{number}    { printf("number: %s\n", yytext); }
{operator}  { printf("operator: %s\n", yytext); }
"("         { printf("left paren\n"); }
")"         { printf("right paren\n"); }
"K"         { printf("variable: K\n"); }
"s"         { printf("variable: s\n"); }
"a"         { printf("variable: a\n"); }
"b"         { printf("variable: b\n"); }
"c"         { printf("variable: c\n"); }
"d"         { printf("variable: d\n"); }
"sqrt"      { printf("fn: square root\n"); }
.           { fprintf(stderr, "unknown char: %s\n", yytext); }
%%
    
int main()
{
    yylex();
    return 0;
}
