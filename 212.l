%{
int words = 0, characters = 0, lines = 0;
%}

%%

[a-zA-Z_][a-zA-Z0-9_]* { words++; characters += yyleng; }
[ \t] { characters++; }
\n { lines++; }
[0-9]+ { characters += yyleng; }
[(){}<>;=+\-*/] { characters++; }
. { characters++; }

%%

int yywrap() {
	return 1;
}

int main(void) {
	yylex();
	printf("Character: %d, Word: %d, Line: %d\n", characters, words, lines);
	return 0;
}