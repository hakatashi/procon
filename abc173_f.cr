n = read_line.to_i64
ans = 0_i64
1_i64.upto(n) do |i|
  ans += i * (n - i + 1)
end
(n - 1).times do |i|
  u, v = read_line.split.map(&.to_i64).sort!
  ans -= u * (n - v + 1)
end
p ans