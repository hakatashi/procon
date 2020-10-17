# -*- mode: float -*-

gets
xs = read_line.split.map(&.to_i64)
p xs.map(&.abs).sum
p Math.sqrt(xs.map {|x| x.to_f64 ** 2}.sum)
p xs.map(&.abs).max
