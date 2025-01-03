#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int isDigit(char c) {
	return (c >= '0' && c <= '9');
}

void accept (const char *s) {
	printf("%s\n", s); exit(0);
}

void state18(char s[], int ptr) {
	if(strlen(s) == ptr) accept("Floating point number with exponentiation");
	if(isDigit(s[ptr])) state18(s, ptr + 1);
}

void state17(char s[], int ptr) {
	if(strlen(s) == ptr) return;
	if(isDigit(s[ptr])) state18(s, ptr + 1);
}

void state16(char s[], int ptr) {
	if(strlen(s) == ptr) return;
	if(isDigit(s[ptr])) state18(s, ptr + 1);
	else if(s[ptr] == '+' || s[ptr] == '-') state17(s, ptr + 1);
}

void state15(char s[], int ptr) {
	if(strlen(s) == ptr) accept("Floating point number");
	if(isDigit(s[ptr])) state15(s, ptr + 1);
	else if(s[ptr] == 'E') state16(s, ptr + 1);
}

void state14(char s[], int ptr) {
	if(strlen(s) == ptr) return;
	if(isDigit(s[ptr])) state15(s, ptr + 1);
}

void state13(char s[], int ptr) {
	if(strlen(s) == ptr) accept("Integer number");
	if(isDigit(s[ptr])) state13(s, ptr + 1);
	else if(s[ptr] == '.') state14(s, ptr + 1);
	else if(s[ptr] == 'E') state16(s, ptr + 1);
}

int main()
{
	printf("Enter a number: ");
	char s[100]; scanf("%s", s);
	int n = strlen(s);
	
	printf("%s: ", s);
	
	if(isDigit(s[0])) state13(s, 1);	
	
	printf("Not a number\n");
	
	return 0;
}