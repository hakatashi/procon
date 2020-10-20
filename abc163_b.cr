n, m = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)
ans = n - ais.sum
p ans < 0 ? -1 : ans
