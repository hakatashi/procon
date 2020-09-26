#include <bits/stdc++.h>
#include <atcoder/mincostflow>

using namespace atcoder;
using namespace std;

#define ll long long int

struct phash
{
  inline size_t operator()(const tuple<int, int> &p) const
  {
    const auto h1 = hash<int>()(get<0>(p));
    const auto h2 = hash<int>()(get<1>(p));
    return h1 ^ (h2 << 1);
  }
};

int main() {
  ll n, m;
  cin >> n >> m;
  vector<string> cells;
  vector<tuple<int, int>> pieces;
  for (size_t y = 0; y < n; y++) {
    string s;
    cin >> s;
    cells.push_back(s);
    for (size_t x = 0; x < s.size(); x++) {
      auto c = s[x];
      if (c == 'o') {
        pieces.push_back(make_tuple(x, y));
      }
    }
  }

  mcf_graph<ll, ll> flow(n * m + pieces.size() + 2);
  ll from = 0;
  ll cell_offset = pieces.size() + 1;
  ll to = n * m + pieces.size() + 1;

  for (size_t i = 0; i < pieces.size(); i++) {
    flow.add_edge(from, i + 1, 1, 0);
  }
  for (size_t i = 0; i < n * m; i++) {
    flow.add_edge(cell_offset + i, to, 1, 0);
  }

  for (size_t i = 0; i < pieces.size(); i++) {
    int x = get<0>(pieces[i]);
    int y = get<1>(pieces[i]);

    queue<tuple<int, int, int>> queue;
    queue.push(make_tuple(x, y, 0));
    unordered_set<tuple<int, int>, phash> visited;
    visited.insert(make_tuple(x, y));

    while (!queue.empty()) {
      tuple<int, int, int> item = queue.front();
      queue.pop();
      int x = get<0>(item);
      int y = get<1>(item);
      int depth = get<2>(item);

      flow.add_edge(i + 1, cell_offset + y * m + x, 1, 200-depth);
      if (x + 1 < m && cells[y][x + 1] != '#' && visited.find(make_tuple(x + 1, y)) == visited.end()) {
        queue.push(make_tuple(x + 1, y, depth + 1));
        visited.insert(make_tuple(x + 1, y));
      }
      if (y + 1 < n && cells[y + 1][x] != '#' && visited.find(make_tuple(x, y + 1)) == visited.end()) {
        queue.push(make_tuple(x, y + 1, depth + 1));
        visited.insert(make_tuple(x, y + 1));
      }
    }
  }
  
  pair<ll, ll> ans = flow.flow(from, to);
  cout << 200 * pieces.size() - ans.second << endl;
  
  return 0;
}
