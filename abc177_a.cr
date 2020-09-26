d, t, s = read_line.split.map(&.to_i64)
puts t * s >= d ? "Yes" : "No"