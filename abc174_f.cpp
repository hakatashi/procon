// https://ei1333.hateblo.jp/entry/2017/09/11/211011

#include <vector>
#include <math.h>
#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <numeric>
using namespace std;

struct Mo
{
  vector< int > left, right, order;
  vector< bool > v;
  int width;
  int nl, nr, ptr;

  Mo(int n) : width((int) sqrt(n)), nl(0), nr(0), ptr(0), v(n) {}

  void insert(int l, int r) /* [l, r) */
  {
    left.push_back(l);
    right.push_back(r);
  }

  /* ソート */
  void build()
  {
    order.resize(left.size());
    iota(begin(order), end(order), 0);
    sort(begin(order), end(order), [&](int a, int b)
    {
      if(left[a] / width != left[b] / width) return left[a] < left[b];
      return right[a] < right[b];
    });
  }

  /* クエリを 1 つぶんすすめて, クエリのidを返す */
  int process()
  {
    if(ptr == order.size()) return (-1);
    const auto id = order[ptr];
    while(nl > left[id]) distribute(--nl);
    while(nr < right[id]) distribute(nr++);
    while(nl < left[id]) distribute(nl++);
    while(nr > right[id]) distribute(--nr);
    return (order[ptr++]);
  }

  inline void distribute(int idx)
  {
    v[idx].flip();
    if(v[idx]) add(idx);
    else del(idx);
  }

  void add(int idx);

  void del(int idx);
};

int N, A[1000000], Q;
int ans[1000000];
int cnt[2000001], sum;

void Mo::add(int idx)
{
  if(cnt[A[idx]]++ == 0) ++sum;
}

void Mo::del(int idx)
{
  if(--cnt[A[idx]] == 0) --sum;
}

int main()
{
  scanf("%d %d", &N, &Q);
  for(int i = 0; i < N; i++) {
    scanf("%d", &A[i]);
  }
  Mo mo(N);
  for(int i = 0; i < Q; i++) {
    int a, b;
    scanf("%d %d", &a, &b);
    mo.insert(--a, b);
  }
  mo.build();
  for(int i = 0; i < Q; i++) {
    ans[mo.process()] = sum;
  }
  for(int i = 0; i < Q; i++) {
    printf("%d\n", ans[i]);
  }
}