n, k = read_line.split.map(&.to_i64)
hs = read_line.split.map(&.to_i64)
hs.sort!
p hs[0...[n - k, 0].max].sum
