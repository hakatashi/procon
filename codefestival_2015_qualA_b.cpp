#include <bits/stdc++.h>

using namespace std;

int main() {
	ios_base::sync_with_stdio(false);

	int N, A[30], sum;

	cin >> N;

	for (int i = 0; i < N; i++) {
		cin >> A[i];
	}

	sum = 0;

	for (int i = 0; i < N; i++) {
		sum = sum * 2 + A[i];
	}

	cout << sum << endl;

	return 0;
}
