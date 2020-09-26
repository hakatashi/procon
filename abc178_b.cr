a, b, c, d = read_line.split.map(&.to_i64)
p [a * c, a * d, b * c, b * d].max