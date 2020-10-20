gets
ais = read_line.split.map(&.to_i)
bs = read_line.split.map(&.to_i)
cs = read_line.split.map(&.to_i)
ret = bs.sum
ais.each_cons(2) do |(a, b)|
  if b - a == 1
    ret += cs[a - 1]
  end
end
p ret
