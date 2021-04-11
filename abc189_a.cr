s = read_line.chars
puts s.uniq.size == 1 ? "Won" : "Lost"