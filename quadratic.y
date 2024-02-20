%{
/* This parser parses a quadratic formula of the form:
 * x = (-b ± sqrt(b ^ 2 - 4 * a * c)) / (2 * a)
 */
#include <stdio.h>
#include <string.h>
#include <math.h>

extern int yylex();
void yyerror(char*);

void assert_token(int, int);

int a, b, c;
double x1, x2;
%}

%token VARIABLE_X VARIABLE_A VARIABLE_B VARIABLE_C SIGNUM LPAREN RPAREN ASSIGNMENT_OP SQRT NUMBER;

%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%start stmt

%%
stmt:
    VARIABLE_X ASSIGNMENT_OP expr                                       { printf("The roots of the equation are %.2f and %.2f\n", x1, x2); }
expr:
    numer '/' denom                                                     { x1 = x1 / $3; x2 = x2 / $3; }
numer:
    LPAREN '-' %prec '*' VARIABLE_B SIGNUM root RPAREN                  { x1 = -b + $5; x2 = -b - $5; }
root:
    SQRT LPAREN root_arg RPAREN                                         { $$ = sqrt($3); }
root_arg:
    VARIABLE_B '^' NUMBER '-' NUMBER '*' VARIABLE_A '*' VARIABLE_C      {
                                                                            assert_token($3, 2);
                                                                            assert_token($5, 4);
                                                                            $$ = pow(b, 2) - 4 * a * c;
                                                                        }
denom:
    LPAREN NUMBER '*' VARIABLE_A RPAREN                                 { assert_token($2, 2); $$ = 2 * a; }
%%

void assert_token(int actual, int expected)
{
    if (actual != expected) {
        fprintf(stderr, "expected token %d, got %d\n", expected, actual);
    }
}

int main()
{
    printf("enter values for a, b and c: ");
    scanf("%d %d %d", &a, &b, &c);

    yyparse();

    return 0;
}

void yyerror(char* s) {
    fprintf(stderr, "%s\n", s);
} 