#include <iostream>
#include <string>
using namespace std;

int main(int argc, char const *argv[]) {
	string s;
	int ans;
	cin >> s;
	ans = s.size();

	for (size_t i = 0; i < s.size(); i++) {
		if (s[i] == 'A') {
			break;
		}
		ans--;
	}

	for (size_t i = 0; i < s.size(); i++) {
		if (s[s.size() - i - 1] == 'Z') {
			break;
		}
		ans--;
	}

	cout << ans << endl;

	return 0;
}
