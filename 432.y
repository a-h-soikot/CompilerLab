%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *msg);
int yylex();
%}

%token LETTER DIGIT

%%

VARIABLE : LETTER MORE { printf("Valid variable name\n"); }
     ;

MORE : LETTER MORE
	  | DIGIT MORE
	  | /* epsilon */
	  ;

%%

void yyerror(const char *msg)
{
    printf("Invalid variable name\n");
}

int main()
{
    printf("Enter a variable name:\n");
    yyparse();
    return 0;
}
