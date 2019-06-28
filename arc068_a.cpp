#include <iostream>
#include <string>
using namespace std;

int main(int argc, char const *argv[]) {
	long long int N;
	cin >> N;
	long long int div = N / 11;
	long long int rem = N % 11;
	if (rem == 0) {
		cout << div * 2 << endl;
	} else if (rem <= 5) {
		cout << div * 2 + 1 << endl;
	} else {
		cout << div * 2 + 2 << endl;
	}
	return 0;
}
