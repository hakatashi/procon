n, m, c = read_line.split.map(&.to_i)
bs = read_line.split.map(&.to_i)
ret = 0
n.times do 
  ais = read_line.split.map(&.to_i)
  if ais.zip(bs).sum {|(a, b)| a * b} + c > 0
    ret += 1
  end
end
p ret
