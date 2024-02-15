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
%}

digit       [0-9]
whitesp     [ \t\n]        
op          [-\*]

%%
{whitesp}+  ; // ignore whitespace
{op}        { return *yytext; }
"="         { return (ASSIGNMENT_OP); }
"("         { return LPAREN; }
")"         { return RPAREN; }
"K"         { return VARIABLE_K; }
"s"         { return VARIABLE_S; }
"a"         { return VARIABLE_A; }
"b"         { return VARIABLE_B; }
"c"         { return VARIABLE_C; }
"d"         { return VARIABLE_D; }
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
