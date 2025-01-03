#include <bits/stdc++.h>
using namespace std;

map<char, set<char>> mp;
set<char> states;

set<char> e_closure;

void transition(char state) {
	if(e_closure.count(state)) return;
	e_closure.insert(state);
	
	for(char s : mp[state]) {
		transition(s);
	}
}
	
int main()
{
	char state, t, dstate;
	
	while(cin >> state >> t >> dstate) {
		states.insert(state); states.insert(dstate);
		if(t != 'e' or state == dstate) continue;
		mp[state].insert(dstate);
	}
	
	cout << "No of states: " << states.size() << endl;
	cout << "States are:\n";
	for(char c : states) cout << c << endl;
	
	for(char state : states) {
		
		e_closure.clear();
		
		transition(state);
		
		cout << "Epsilon closure of (" << state << ") = { ";
		for(char c : e_closure) cout << c << " ";
		cout << "}\n";
		
	}
	
	return 0;
}