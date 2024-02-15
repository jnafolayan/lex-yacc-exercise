%{
/* This parser parses a quadratic formula of the form:
 * K = sqrt(s * (s - a) * (s - b) * (s - c) * (s - d))
 */
#include <stdio.h>
#include <string.h>
#include <math.h>

extern int yylex();
void yyerror(char*);

double s, a, b, c, d;
%}

%union {
    double number;
}

%token VARIABLE_K VARIABLE_S VARIABLE_A VARIABLE_B VARIABLE_C VARIABLE_D LPAREN RPAREN ASSIGNMENT_OP SQRT;

%left '-'
%left '*'

%type <number> s_a s_b s_c s_d root_arg expr

%start stmt

%%
stmt:
    VARIABLE_K ASSIGNMENT_OP expr                               { printf("K = %.2lf\n", $3); }
expr:
    SQRT LPAREN root_arg RPAREN                                 { $$ = sqrt($3); }
root_arg:
    VARIABLE_S '*' s_a '*' s_b '*' s_c '*' s_d                  { $$ = s * $3 * $5 * $7 * $9; }
s_a:
    LPAREN VARIABLE_S '-' VARIABLE_A RPAREN                     { $$ = s - a; }
s_b:
    LPAREN VARIABLE_S '-' VARIABLE_B RPAREN                     { $$ = s - b; }
s_c:
    LPAREN VARIABLE_S '-' VARIABLE_C RPAREN                     { $$ = s - c; }
s_d:
    LPAREN VARIABLE_S '-' VARIABLE_D RPAREN                     { $$ = s - d; }
%%

int main()
{
    printf("enter values for s, a, b, c and d: ");
    scanf("%lf %lf %lf %lf %lf", &s, &a, &b, &c, &d);

    yyparse();  

    return 0;
}

void yyerror(char* s) {
    fprintf(stderr, "%s\n", s);
} 