#include <bits/stdc++.h>

using namespace std;

int main() {
	ios_base::sync_with_stdio(false);

	int N, T, A[100000], B[100000], diff[100000], Asum = 0;

	cin >> N >> T;

	for (int i = 0; i < N; i++) {
		cin >> A[i] >> B[i];
		diff[i] = A[i] - B[i];
		Asum += A[i];
	}

	sort(diff, diff + N);

	for (int i = 0; i <= N; i++) {
		if (T < Asum) {
			if (i < N) {
				Asum -= diff[N - i - 1];
			}
		} else {
			cout << i << endl;
			return 0;
		}
	}

	cout << -1 << endl;
	return 0;
}
