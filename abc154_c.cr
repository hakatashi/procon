gets
ais = read_line.split.map(&.to_i64)
puts ais.uniq.size == ais.size ? "YES" : "NO"