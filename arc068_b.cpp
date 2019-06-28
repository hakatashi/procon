#include <iostream>
#include <string>
#include <vector>
using namespace std;

int main(int argc, char const *argv[]) {
	int N;
	cin >> N;
	int map[100001] = {0};
	int tmp;
	for (size_t i = 0; i < N; i++) {
		cin >> tmp;
		map[tmp]++;
	}
	int dups = 0;
	for (size_t i = 1; i < 100000; i++) {
		if (map[i] >= 2) {
			dups += map[i] - 1;
		}
	}

	cout << N - (dups + 1) / 2 * 2 << endl;

	return 0;
}
