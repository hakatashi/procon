gets
vs = read_line.split.map(&.to_i)
cs = read_line.split.map(&.to_i)
p vs.zip(cs).map { |v, c| [v - c, 0].max }.sum
