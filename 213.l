%{
#include <string.h>
%}

%%

[ \t\n] { } // Ignore whitespace

\"([^"\\]|\\.)*\" { printf("%s: String\n", yytext); }

\'([^\'\\]|\\.)\' { printf("%s: Character\n", yytext); }

"if"|"else"|"while"|"for"|"return"|"void" { printf("%s:Keyword\n", yytext); }

"int" { printf("int: Integer\n"); }

"char" { printf("char: Character\n"); }

[0-9]+ { printf("%s: digit(s)\n", yytext); }

[a-zA-Z][a-zA-Z0-9]* { printf("%s: Identifier\n", yytext); }

[a-zA-Z_][a-zA-Z0-9_]*"(" { printf("%.*s: Function\n(:Bracket\n", strlen(yytext) - 1, yytext); }

"=" { printf("=: AssignmentOperator\n"); }
"+" { printf("+: plus\n"); }
"-" { printf("-: minus\n"); }
"*" { printf("*: multiplication\n"); }
"/" { printf("/: division\n"); }
";" { printf(";: semicolon\n"); }

[\(\)\{\}\[\]]   { printf("%s: Bracket\n", yytext); }
. 	{ printf("Unknown character\n"); }

%%

int yywrap() {
	return 1;
}

int main() {
	yylex();
	return 0;
}
