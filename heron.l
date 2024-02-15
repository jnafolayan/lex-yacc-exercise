%{
/* This scanner recognises the variables, numbers and operators in the formula:
 * K = sqrt(s * (s - a) * (s - b) * (s - c) * (s - d))
 */
#include <stdio.h>
#include "tokens.h"
%}

digit       [0-9]
number      {digit}+(\.{digit}+)?
operator    [-\*=]
whitesp     [ \t\n]

%%
{whitesp}+  ; // ignore whitespace
{number}    { printf("number: %s\n", yytext); return NUMBER; }
{operator}  { printf("operator: %s\n", yytext); return OPERATOR; }
"("         { printf("left paren\n"); return LPAREN; }
")"         { printf("right paren\n"); return RPAREN; }
"K"         { printf("variable: K\n"); return VARIABLE; }
"s"         { printf("variable: s\n"); return VARIABLE; }
"a"         { printf("variable: a\n"); return VARIABLE; }
"b"         { printf("variable: b\n"); return VARIABLE; }
"c"         { printf("variable: c\n"); return VARIABLE; }
"d"         { printf("variable: d\n"); return VARIABLE; }
"sqrt"      { printf("fn: square root\n"); return FUNC; }
.           { fprintf(stderr, "unknown char: %s\n", yytext); return UNKNOWN; }
%%

int yywrap()
{
    return 1;
}
    
int main()
{
    // Parse the incoming stream of characters. Abort when an unknown character
    // is encountered.
    int cur_token = 0;
    while ((cur_token = yylex()) != UNKNOWN && cur_token != 0); // 0 is returned for EOF
    return 0;
}
