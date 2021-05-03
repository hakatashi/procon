#include <iostream>
using namespace std;
int main() {
  int n;
  double a;
  double ret = 0.0;
  cin >> n;
  for (int i = 0; i < n; i++) {
    cin >> a;
    ret += 1.0 / a;
  }
  cout << 1.0 / ret << endl;
  return 0;
}