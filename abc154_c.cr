gets
puts read_line.split.map(&.to_i64).sort.each_cons(2).any? {|(a, b)| a == b} ? "NO" : "YES"