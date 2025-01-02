%{
#include "432.tab.h"
%}

%%

[a-zA-Z]	{ return LETTER; }
[0-9]       { return DIGIT; }
[ \t\n]+    { /* Ignore whitespace */ }
.           { printf("Illegal characters found, invalid variable name"); exit(0); }

%%

int yywrap() {
    return 1; // End of input.
}
