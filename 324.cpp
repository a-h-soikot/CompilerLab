#include <bits/stdc++.h>
using namespace std;

struct Grammar {
    string nonTerminal;
    vector<string> productions;
};

void RemoveWhiteSpace(string &s) {
	string t;
	for(char c : s) if(c != ' ') t.push_back(c);
	s = t;
}

string get_next(int &i, string &line) {
    string str;

    while(i < line.size() and line[i] != '|') {
        str.push_back(line[i]); ++i;
    }
    ++i;

    return str;
}

void Replace(Grammar &replace, vector<string> productions, int k) {

    string alpha = replace.productions[k].substr(1);
    replace.productions.erase(replace.productions.begin() + k);

    for(string P : productions) {
        replace.productions.insert(replace.productions.begin() + k, P + alpha);
        ++k;
    }
}

void RemoveImmediate(Grammar eliminated[], Grammar &replaced_production, int &eN) {
    vector<string> alpha, beta;
    
    for(string P : replaced_production.productions) {
        if(P[0] == replaced_production.nonTerminal[0]) alpha.push_back(P.substr(1));
        else beta.push_back(P);
    }
    
    if(alpha.size() == 0) return void();

    replaced_production.productions.clear();

    for(string B : beta) replaced_production.productions.push_back(B + replaced_production.nonTerminal[0] + "'");

    eN += 1; eliminated[eN].nonTerminal = replaced_production.nonTerminal + "'";
    
    for(string A : alpha) eliminated[eN].productions.push_back(A + replaced_production.nonTerminal[0] + "'");
    eliminated[eN].productions.push_back("e");
}

int main ()
{   
    Grammar rules[100]; int N = 0;

    string line;
    
    printf("Enter the Grammar Rules:\n");

    while(getline(cin, line)) {
    	RemoveWhiteSpace(line);
        rules[N].nonTerminal = line[0];
        
        int i = 3;

        while(i < line.size()) {
            rules[N].productions.push_back(get_next(i, line));
        }
        
        N += 1;
    }

    Grammar eliminated[100]; int eN = 0;

    for(int i = 0; i < N; i++) {

        eliminated[eN] = rules[i];
        
        for(int j = 0; j < eN; j++) {
            if(eliminated[j].nonTerminal.size() > 1) continue;
            for(int k = 0; k < eliminated[eN].productions.size(); k++) {
                if(eliminated[eN].productions[k][0] == eliminated[j].nonTerminal[0]) {
                    Replace(eliminated[eN], eliminated[j].productions, k);
                }
            }
        }

        RemoveImmediate(eliminated, eliminated[eN], eN);

        eN += 1;
    }
    
    printf("\nGrammar with eliminated left recursion:\n");

    for(int i = 0; i < eN; i++) {
        cout << eliminated[i].nonTerminal << " ->";
        for(int j = 0; j < eliminated[i].productions.size(); j++) {
            if(j > 0)  cout << " |";
            cout << " " << eliminated[i].productions[j];
        }
        cout << endl;
    }

    return 0;
}