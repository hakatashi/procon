h = read_line.to_i
w = read_line.to_i
n = read_line.to_i
a = 0

200.times do |i|
  if h > w
    a += h
    w -= 1
  else
    a += w
    h -= 1
  end
  if a >= n
    p i + 1
    exit
  end
end
