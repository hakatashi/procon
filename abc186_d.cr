n = read_line.to_i64
ais = read_line.split.map(&.to_i64).sort!
ans = 0_i64
ais.each.with_index.each_cons_pair do |(a, i), (b, j)|
  ans += (b - a) * j * (n - j)
end
p ans
