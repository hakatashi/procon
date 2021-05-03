#include <iostream>
#include <vector>
#include <unordered_set>
#include <math.h>

using namespace std;

int main() {
  int h, w;
  cin >> h;
  cin >> w;
  int board[6400];
  for (size_t i = 0; i < h * w; i++) {
    cin >> board[i];
  }
  int tmp;
  for (size_t i = 0; i < h * w; i++) {
    cin >> tmp;
    board[i] = abs(board[i] - tmp);
  }
  vector<unordered_set<int>> dps;
  for (size_t x = 0; x < h; x++) {
    for (size_t y = 0; y < w; y++) {
      unordered_set<int> dp;
      auto c = board[y * w + x];
      if (x == 0 && y == 0) {
        dp.insert(c);
      } else {
        if (x != 0) {
          for (auto& v: dps[y * w + x - 1]) {
            if (v + c <= 6400) {
              dp.insert(v + c);
            }
            if (abs(v - c) <= 6400) {
              dp.insert(abs(v - c));
            }
          }
        }
        if (y != 0) {
          for (auto& v: dps[(y - 1) * w + x]) {
            if (v + c <= 6400) {
              dp.insert(v + c);
            }
            if (abs(v - c) <= 6400) {
              dp.insert(abs(v - c));
            }
          }
        }
      }
      dps.push_back(dp);
    }
  }
  int ret = 99999999;
  auto dp = dps[h * w - 1];
  for (auto& v: dp) {
    if (ret > v) {
      ret = v;
    }
  }
  cout << ret << endl;
  return 0;
}