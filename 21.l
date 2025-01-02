%{
#include <stdio.h>
%}

%%

[0-9]+              { printf("%s: Integer number\n", yytext); }
[0-9]+\.[0-9]+      { printf("%s: Floating point number\n", yytext); }
[0-9]+\.[0-9]+[E][+-]?[0-9]+ { printf("%s: Floating point number with exponentiation\n", yytext); }
[a-zA-Z]+			{ printf("%s: Not a number\n", yytext); }
.                   { printf("%s: Not a number\n", yytext); }

%%

int yywrap() {
    return 1;  // Indicates no more input.
}

int main() {
    printf("Enter a number: ");
    yylex();
    return 0;
}
