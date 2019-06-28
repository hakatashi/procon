#include <iostream>
#include <string>
using namespace std;

#define P 1000003

long long int pow(long long int a, long long int n) {
	long long int ret = 1;
	while (n > 0) {
		if (n & 1) {
			ret = (ret * a) % P;
		}
		a = (a * a) % P;
		n >>= 1;
	}
	return ret;
}

long long int inv(long long int a) {
	return pow(a, P - 2);
}

int main(int argc, char const *argv[]) {
	long long int Q;
	long long int f[P];

	f[0] = 1;
	f[1] = 1;
	for (size_t i = 2; i < P; i++) {
		f[i] = (f[i - 1] * i) % P;
	}

	cin >> Q;
	for (size_t i = 0; i < Q; i++) {
		long long int x, d, n;
		cin >> x >> d >> n;

		if (x % P == 0) {
			cout << 0 << endl;
			continue;
		}

		if (d == 0) {
			cout << pow(x, n) << endl;
			continue;
		}

		long long int z = ((P - x) * inv(d)) % P;
		long long int start = P - z;
		long long int end = start + n - 1;

		if (z == 0 || end >= P) {
			cout << 0 << endl;
			continue;
		}

		long long int startmod = (pow(d, start - 1) * f[start - 1]) % P;
		long long int endmod = (pow(d, end) * f[end]) % P;
		long long int answer = (endmod * inv(startmod)) % P;

		cout << answer << endl;
	}
	return 0;
}
