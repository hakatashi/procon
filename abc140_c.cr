gets
bs = read_line.split.map(&.to_i)
p bs.first + bs.each_cons(2).map(&.min).sum + bs.last
