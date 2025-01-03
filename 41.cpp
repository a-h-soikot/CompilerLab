#include <bits/stdc++.h>
using namespace std;

void RemoveWhiteSpace(string &line) {
	string t;
	for(char c : line) if(c != ' ') t.push_back(c);
	line = t;
}

int main()
{
	string line; getline(cin, line); 
	
	RemoveWhiteSpace(line);
	
	vector<string> v; 
	
	char id = line[0];
	
	int cnt = 1;
	
	cout << "\nThree Adress Code:\n";
	
	for(int i = 2; i < line.size(); i++) {

		if(line[i] == '*' or line[i] == '/') {
			cout << "t" << cnt << "=" << v.back() << line[i] << line[i+1] << endl;
			v.pop_back(); v.push_back("t" + to_string(cnt));
			cnt++; i++;
		} else {
			v.push_back(string(1, line[i]));
		}
	}
	
	reverse(v.begin(), v.end()); 
	
	while(v.size() > 1) {
		cout << "t" << cnt << "=";
		
		cout << v.back(); v.pop_back(); 
		cout << v.back(); v.pop_back(); 
		cout << v.back() << endl; v.pop_back();
		
		v.push_back("t" + to_string(cnt));
		cnt++;
	}
	
	cout << id << "=" << v.back();

	return 0;
}