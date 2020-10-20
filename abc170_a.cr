xs = read_line.split.map(&.to_i64)
p xs.index(0_i64).not_nil! + 1
