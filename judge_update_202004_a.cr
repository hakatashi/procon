s, l, r = read_line.split.map(&.to_i64)
p s.clamp(l, r)
