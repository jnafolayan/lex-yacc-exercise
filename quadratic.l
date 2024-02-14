%{
/* This scanner recognises the variables, numbers and operators in the formula:
 * x = (-b ± sqrt(b ^ 2 - 4 * a * c)) / (2 * a)
 */
#include <stdio.h>
#include "tokens.h"

#ifndef YYSTYPE 
#define YYSTYPE int
#endif
extern YYSTYPE yylval;
%}

digit       [0-9]
number      {digit}+(\.{digit}+)?
operator    [\+\-\*/\^]
whitesp     [ \t\n]        

%%
{whitesp}+  ; // ignore whitespace
{number}    { printf("number: %s\n", yytext); yylval = atoi(yytext); return (NUMBER); }
{operator}  { printf("operator: %s\n", yytext); yylval = *yytext; return (OPERATOR); }
"±"         { printf("plus-minus operator"); return (PLUS_MINUS); }
"="         { printf("assignment\n"); return (ASSIGNMENT_OP); }
"("         { printf("left paren\n"); return (LPAREN); }
")"         { printf("right paren\n"); return (RPAREN); }
"x"         { printf("variable: x\n"); return (VARIABLE_X); }
"a"         { printf("variable: a\n"); return (VARIABLE_A); }
"b"         { printf("variable: b\n"); return (VARIABLE_B); }
"c"         { printf("variable: c\n"); return (VARIABLE_C); }
"sqrt"      { printf("fn: square root\n"); return (SQRT); }
.           { fprintf(stderr, "unknown char: %s\n", yytext); return (UNKNOWN); }
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
