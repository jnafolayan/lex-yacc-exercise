%{
/* This parser parses a quadratic formula of the form:
 * x = (-b ± sqrt(b ^ 2 - 4 * a * c)) / (2 * a)
 */
#include <stdio.h>
#include "tokens.h"

extern int yylex();
void yyerror(char*);
%}


%token NUMBER;
%token ASSIGNMENT_OP PLUS_MINUS LPAREN RPAREN FUNC;

%left '+' '-'
%left '*' '/'

%start stmt

%%
stmt:
    x ASSIGNMENT_OP expr
    ;
expr:
    numer OPERATOR denom                            { assert_token($2, "/"); }
    ;
numer:
    LPAREN OPERATOR VARIABLE PLUS_MINUS root RPAREN { assert_token($2, "-"); }
    ;
root:
    SQRT LPAREN root_arg RPAREN
    ;
root_arg:
    VARIABLE_B OPERATOR NUMBER OPERATOR NUMBER OPERATOR VARIABLE_A OPERATOR VARIABLE_C   {
                                                                                        assert_token($2, "^");
                                                                                        assert_token($3, "2");
                                                                                        assert_token($4, "-");
                                                                                        assert_token($5, "4");
                                                                                        assert_token($6, "*");
                                                                                        assert_token($7, "*");
                                                                                    }
    ;
denom:
    LPAREN NUMBER OPERATOR VARIABLE_A { assert_token($2, "2"); assert_token($3, "*"); }
%%

void assert_token(const char* actual, const char* expected)
{
    if (strcmp(actual, expected) != 0) {
        fprintf(stderr, "expected token %s, got %s\n", expected, actual);
    }
}

int main()
{
    int a, b, c;
    printf("enter values for a, b and c: ");
    scanf("%d %d %d", &a, &b, &c);

    yyparse();
    return 0;
}

void yyerror(char* s) {
    fprintf(stderr, "%s\n", s);
} 