n, k = read_line.split.map(&.to_i64)
ps = read_line.split.map(&.to_i64)
p ps.sort![...k].sum
