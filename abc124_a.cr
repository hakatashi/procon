a, b = read_line.split.map(&.to_i)
if a == b
  p a + b
else
  p [a, b].max * 2 - 1
end
