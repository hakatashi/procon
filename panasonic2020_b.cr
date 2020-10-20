h, w = read_line.split.map(&.to_i64)
if h == 1 || w == 1
  p 1
elsif h % 2 == 0 || w % 2 == 0
  p h * w // 2
else
  p h * w // 2 + 1
end
