a, b, c = read_line.split.map(&.to_i)
puts (a + b + c >= 22) ? "bust" : "win"