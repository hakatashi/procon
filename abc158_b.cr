n, a, b = read_line.split.map(&.to_i64)
ans = n // (a + b) * a
ans += [n % (a + b), a].min
p ans
