%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *msg);
int yylex();
%}

%token A B NL

%%

G : S NL { printf("Valid string.\n"); exit(0); }
  ;
  
S : A S B {  }
	| /* empty */
  ;

%%

void yyerror(const char *msg) {
    printf("Invalid string.\n");
    exit(1);
}

int main() {
    printf("Enter a string: ");
    yyparse();
    return 0;
}
