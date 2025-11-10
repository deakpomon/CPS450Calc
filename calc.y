%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}
%token NUMBER

%%
input:
    /* empty */
  | input line
  ;

line:
    expr '\n'      { printf("%d\n", $1); }
  ;

expr:
    expr '+' expr  { $$ = $1 + $3; }
  | expr '-' expr  { $$ = $1 - $3; }
  | expr '*' expr  { $$ = $1 * $3; }
  | expr '/' expr  { $$ = $1 / $3; }
  | '(' expr ')'   { $$ = $2; }
  | NUMBER         { $$ = $1; }
  ;

%%
int main(void) {
    return yyparse();
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
