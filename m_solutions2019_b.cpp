#include <iostream>
#include <string>
using namespace std;

int main(int argc, char const *argv[]) {
	string S;
	cin >> S;
	int loses = 0;
	for (size_t i = 0; i < S.size(); i++) {
		if (S[i] == 'x') {
			loses++;
		}
	}
	if (loses >= 8) {
		cout << "NO" << endl;
	} else {
		cout << "YES" << endl;
	}
	return 0;
}
