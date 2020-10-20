n, k = read_line.split.map(&.to_i)
hs = read_line.split.map(&.to_i)
p hs.count { |h| h >= k }
