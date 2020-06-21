n = read_line.to_i64
ais = read_line.split.map(&.to_i64)
sum = ais.reduce {|a, b| a ^ b}
puts ais.map {|a| sum ^ a}.join(' ')