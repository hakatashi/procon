#include <bits/stdc++.h>

using namespace std;

int main() {
	ios_base::sync_with_stdio(false);

	long long int N, K, M, R;
	vector<long long int> S;

	cin >> N >> K >> M >> R;

	for (int i = 0; i < N - 1; i++) {
		long long int s;
		cin >> s;
		S.push_back(s);
	}

	sort(S.begin(), S.end());

	long long int sum = 0;
	int i = 0;
	for (auto s: S) {
		if (i >= N - 1 - K) {
			sum += s;
		}
		i++;
	}

	if (sum >= K * R) {
		cout << "0" << endl;
		return 0;
	}

	if (N == K) {
		if (sum + M < K * R) {
			cout << "-1" << endl;
			return 0;
		}
		cout << K * R - sum << endl;
		return 0;
	}

	if (sum - S[N - 1 - K] + M < K * R) {
		cout << "-1" << endl;
		return 0;
	}

	cout << K * R - (sum - S[N - 1 - K]) << endl;

	return 0;
}
