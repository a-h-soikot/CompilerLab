%{
#include "51.tab.h"
%}

%%

a    { return A; }
b    { return B; }
[\r\n]+ { return NL; }

.    { printf("Invalid character: %s\n", yytext); exit(1); }

%%

int yywrap() {
    return 1; // End of input
}
