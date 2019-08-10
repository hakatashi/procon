a, b = read_line.split.map(&.to_i64)
p [a - b, a + b, a * b].max
