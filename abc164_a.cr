s, w = read_line.split.map(&.to_i64)
puts s <= w ? "unsafe" : "safe"