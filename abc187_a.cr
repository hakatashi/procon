a, b = read_line.split
p [a.chars.map(&.to_i).sum, b.chars.map(&.to_i).sum].max