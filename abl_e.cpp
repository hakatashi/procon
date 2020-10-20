#include <bits/stdc++.h>
#include <atcoder/lazysegtree>
#include <atcoder/modint>

#define ll long long int

using namespace std;
using namespace atcoder;

using mint = modint998244353;

struct S
{
  mint v;
  int size;
};

struct F
{
  mint d;
};

S op(S l, S r) { return S{l.v * mint::raw(10).pow(r.size) + r.v, l.size + r.size}; }

S e() { return S{0, 0}; }

S mapping(F l, S r) {
  if (l.d == 10) {
    return r;
  }
  return S{(mint::raw(10).pow(r.size) - 1) / 9 * l.d, r.size};
}

F composition(F l, F r) {
  if (l.d == 10) {
    return r;
  }
  if (r.d == 10) {
    return l;
  }
  return l;
}

F id() { return F{10}; }

int main() {
  ll n, q;
  cin >> n >> q;
  vector<S> a(n);
  for (int i = 0; i < n; i++) {
    a[i] = S{mint::raw(1), 1};
  }
  lazy_segtree<S, op, e, F, mapping, composition, id> seg(a);
  ll ans = n * n;
  for (size_t i = 0; i < q; i++) {
    ll l, r, d;
    cin >> l >> r >> d;
    seg.apply(l - 1, r, F{mint::raw(d)});
    cout << seg.all_prod().v.val() << endl;
  }

  return 0;
}