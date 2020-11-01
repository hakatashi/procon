n = read_line.to_i64
ans = 0_i64
n.times do
  a, b = read_line.split.map(&.to_i64)
  ans += (a + b) * (b - a + 1) // 2
end
p ans
