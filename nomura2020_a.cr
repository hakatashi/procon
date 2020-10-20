h1, m1, h2, m2, k = read_line.split.map(&.to_i64)
p h2 * 60 + m2 - h1 * 60 - m1 - k
