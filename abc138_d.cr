n, q = read_line.split.map(&.to_u64)
children = Array(Array(UInt64)).new(n) { [] of UInt64 }
counters = Array(UInt64).new(n, 0_u64)
rets = Array(UInt64).new(n, 0_u64)
(n - 1).times do
  a, b = read_line.split.map(&.to_u64)
  children[a - 1] << b - 1
end
q.times do
  p_, x = read_line.split.map(&.to_u64)
  counters[p_ - 1] += x
end
def search(node, sum, children, counters, rets)
  sum += counters[node]
  rets[node] = sum
  children[node].each do |child|
    search(child, sum, children, counters, rets)
  end
end
search(0_u64, 0_u64, children, counters, rets)
puts rets.join(" ")