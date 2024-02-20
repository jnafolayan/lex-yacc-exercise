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

void d_print(const char*);
void d_printf(const char*, const char*);

int verbose = 0;

%}

digit       [0-9]
number      {digit}+(\.{digit}+)?
whitesp     [ \t\n]        
op          [-^*/]

%%
{whitesp}+  ; // ignore whitespace
{number}    { d_printf("number: %s", yytext); yylval = atoi(yytext); return (NUMBER); }
{op}        { d_printf("operator %s", yytext); return *yytext; }
"±"         { d_print("operator: signum"); return (SIGNUM); }
"="         { d_print("operator: ="); return (ASSIGNMENT_OP); }
"("         { d_print("left paren\n"); return (LPAREN); }
")"         { d_print("right paren\n"); return (RPAREN); }
"x"         { d_print("variable: X\n"); return (VARIABLE_X); }
"a"         { d_print("variable: a\n"); return (VARIABLE_A); }
"b"         { d_print("variable: b\n"); return (VARIABLE_B); }
"c"         { d_print("variable: c\n"); return (VARIABLE_C); }
"sqrt"      { d_print("fn: square root\n"); return (SQRT); }
";"         { return 0; } // end with a semicolon
.           { fprintf(stderr, "unknown char: %s\n", yytext); return 0; }
%%


void d_print(const char* str)
{
    if (verbose == 1) printf("%s", str);
}

void d_printf(const char* format, const char* ch)
{
    if (verbose == 1) printf(format, ch);
}

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
