n, k = read_line.split.map(&.to_i)
s = read_line
switches = s.chars.each_cons(2).count { |(a, b)| a != b }
p s.size - switches - 1 + [switches, k * 2].min
