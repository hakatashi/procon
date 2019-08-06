a, b, c = read_line.split.map(&.to_i64)
p [0, c - (a - b)].max
