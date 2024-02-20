%{
/* This scanner recognises the variables, numbers and operators in the formula:
 * x = (-b ± sqrt(b ^ 2 - 4 * a * c)) / (2 * a)
 */
#include <stdio.h>
#include <math.h>
#include "quadratic.tab.h"

#ifndef YYSTYPE
#define YYSTYPE int
#endif
YYSTYPE yylval;

int verbose = 0;

%}

digit       [0-9]
number      {digit}+(\.{digit}+)?
whitesp     [ \t\n]        
op          [-^*/]

%%
{whitesp}+  ; // ignore whitespace
{number}    { yylval = atoi(yytext); return (NUMBER); }
{op}        { return *yytext; }
"±"         { return (SIGNUM); }
"="         { return (ASSIGNMENT_OP); }
"("         { return (LPAREN); }
")"         { return (RPAREN); }
"x"         { return (VARIABLE_X); }
"a"         { return (VARIABLE_A); }
"b"         { return (VARIABLE_B); }
"c"         { return (VARIABLE_C); }
"sqrt"      { return (SQRT); }
";"         { return 0; } // end with a semicolon
.           { fprintf(stderr, "unknown char: %s\n", yytext); return 0; }
%%

int yywrap()
{
    return 1;
}

// int main()
// {
//     // Parse the incoming stream of characters. Abort when an unknown character
//     // is encountered.
//     int cur_token = 0;
//     while ((cur_token = yylex()) != UNKNOWN && cur_token != 0); // 0 is returned for EOF
//     return 0;
// }
