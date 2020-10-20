h, n = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)
puts ais.sum >= h ? "Yes" : "No"
