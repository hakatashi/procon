n, k = read_line.split.map(&.to_i64)
p [n % k, k - n % k].min
