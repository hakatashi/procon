#include <bits/stdc++.h>

using namespace std;

int main() {
	ios_base::sync_with_stdio(false);

	string S;
	string replace = "2015";

	cin >> S;

	for (int i = 0; i < 4; i++) {
		S[S.length() - 4 + i] = replace[i];
	}

	cout << S << endl;

	return 0;
}
