#include <atcoder/convolution>
#include <atcoder/modint>
#include <cstdio>
#include <iostream>
#include <algorithm>
#include <vector>
#include <string>

using namespace std;
using namespace atcoder;

int main() {
    string s, t;
    cin >> s;
    cin >> t;

    vector<int> a, b;
    for (char& c : s) {
        if (c == '1') {
            b.push_back(-1);
        } else {
            b.push_back(1);
        }
    }
    for (char& c : t) {
        if (c == '1') {
            a.push_back(1);
        } else {
            a.push_back(-1);
        }
    }
    reverse(a.begin(), a.end());

    vector<int> c = convolution(a, b);
    int i = 0;
    int ans = 1000000000;
    for (auto v : c) {
        if (i >= t.size() - 1 && i < s.size()) {
            int r;
            if (v < 100000000) {
                r = (t.size() - v) / 2 + v;
            } else {
                r = (t.size() - (998244353 - v)) / 2;
            }
            if (ans > r) {
                ans = r;
            }
        }
        i++;
    }

    printf("%d\n", ans);

    return 0;
}