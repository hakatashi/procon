gets
ais = read_line.split.map(&.to_i64)
res = ais.all? {|a| a % 2 == 1 || a % 3 == 0 || a % 5 == 0}
puts res ? "APPROVED" : "DENIED"
