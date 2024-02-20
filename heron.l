%{
/* This scanner recognises the variables, numbers and operators in the formula:
 * K = sqrt(s * (s - a) * (s - b) * (s - c) * (s - d))
 */
#include <stdio.h>
#include "heron.tab.h"

#ifndef YYSTYPE
#define YYSTYPE struct
YYSTYPE yylval;
#endif

void d_print(const char*);
void d_printf(const char*, const char*);

int verbose = 0;
%}

digit       [0-9]
whitesp     [ \t\n]        
op          [-\*]

%%
{whitesp}+  ; // ignore whitespace
{op}        { d_printf("operator: %s", yytext); return *yytext; }
"="         { d_print("operator: ="); return (ASSIGNMENT_OP); }
"("         { d_print("left paren\n"); return LPAREN; }
")"         { d_print("right paren\n"); return RPAREN; }
"K"         { d_print("variable: K\n"); return VARIABLE_K; }
"s"         { d_print("variable: s\n"); return VARIABLE_S; }
"a"         { d_print("variable: a\n"); return VARIABLE_A; }
"b"         { d_print("variable: b\n"); return VARIABLE_B; }
"c"         { d_print("variable: c\n"); return VARIABLE_C; }
"d"         { d_print("variable: d\n"); return VARIABLE_D; }
"sqrt"      { d_print("fn: sqrt\n"); return (SQRT); }
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
