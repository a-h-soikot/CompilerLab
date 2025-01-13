#include <bits/stdc++.h>
using namespace std;

bool isTerminal(char c) {
    return !(c >= 'A' and c <= 'Z' and c != 'N');
}

struct Grammar {
    map<char, vector<string>> productions;
    map<char, set<char>> first_sets;
    map<char, set<char>> follow_sets;
    char start_symbol;
    set<char> non_terminals;

    void add_production(char nonTerminal, string production) {
        productions[nonTerminal].push_back(production);
        non_terminals.insert(nonTerminal);
    }

    void set_start_symbol(char symbol) {
        start_symbol = symbol;
        non_terminals.insert(symbol);
    }

    set<char> calculate_first(char symbol) {
        if (first_sets.count(symbol)) {
            return first_sets[symbol];
        }

        set<char> first;

        if (isTerminal(symbol)) {
            first.insert(symbol);
        } else {
            for (const string& production : productions[symbol]) {
                for (char c : production) {
                    set<char> c_first = calculate_first(c);
                    first.insert(c_first.begin(), c_first.end());
                    if (c_first.count('N') == 0) {
                        break;
                    }
                }
            }
        }

        first_sets[symbol] = first;
        return first;
    }

    void calculate_follow() {
        follow_sets[start_symbol].insert('$');

        bool changed = true;
        while (changed) {
            changed = false;
            for (const auto& p : productions) {
                char A = p.first;
                for (const string& production : p.second) {
                    for (int i = 0; i < production.length(); i++) {
                        char B = production[i];
                        if (non_terminals.count(B)) { 
                            set<char> first_beta;
                            if (i < production.length() - 1) {
                                first_beta = calculate_first(production[i + 1]);
                            } else {
                                first_beta.insert('N');
                            }

                            for (char b : first_beta) {
                                if (b != 'N') {
                                    if (follow_sets[B].insert(b).second) {
                                        changed = true;
                                    }
                                } else {
                                    for (char f : follow_sets[A]) {
                                        if (follow_sets[B].insert(f).second) {
                                            changed = true;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
};

string get_next(int &i, string &line) {
    string str;
    while(line[i] == ' ') ++i;
    while(i < line.size() and line[i] != '|') {
        str.push_back(line[i]); ++i;
    }
    ++i;
    while(str.back() < '(' or str.back() == ' ') str.pop_back();

    return str;
}

int main() {
    Grammar grammar;

    string line; char _start = 'N';

    while(getline(cin, line)) {
        if(_start == 'N') { _start = line[0]; }

        int i = 2;
        while(line[i-1] != '>') i++;
        while(i < line.size()) {
            string str = get_next(i, line);
            grammar.add_production(line[0], str);
        }
    }

    grammar.set_start_symbol(_start);
    
    for (auto& p : grammar.productions) {
        grammar.calculate_first(p.first);
    }

    
    grammar.calculate_follow();

    for (auto& p : grammar.first_sets) {
        if (grammar.non_terminals.count(p.first)) { 
            cout << "First(" << p.first << "): { ";
            for (char c : p.second) {
                cout << c << ", ";
            }
            cout << "}" << endl;
        }
    }

    cout << endl;
    
    for (auto& p : grammar.follow_sets) {
        if (grammar.non_terminals.count(p.first)) { 
            cout << "Follow(" << p.first << "): { ";
            for (char c : p.second) {
                cout << c << ", ";
            }
            cout << "}" << endl;
        }
    }

    return 0;
}