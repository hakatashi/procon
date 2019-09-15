gets
hs = read_line.split.map(&.to_i)
ret = 0
prev = 0
m = 0
hs.each do |h|
  if prev < h
    m = 0
  else
    m += 1
    ret = [ret, m].max
  end
  prev = h
end
puts ret