# verify-helper: PROBLEM https://judge.yosupo.jp/problem/staticrmq

require "./SegmentTree.cr"

n, q = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)
tree = SegmentTree.new(ais) {|a, b| a < b ? a : b}

q.times do
  l, r = read_line.split.map(&.to_i64)
  p tree[l...r]
end
