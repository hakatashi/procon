gets
ais = read_line.split.map(&.to_i)
ret = 0
ais.each do |i|
  if ret + 1 == i
    ret += 1
  end
end
if ret == 0
  p -1
else
  p ais.size - ret
end
