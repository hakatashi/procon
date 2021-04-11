a, b = read_line.split.map(&.to_i64)
if a + b >= 15 && b >= 8
  p 1
elsif a + b >= 10 && b >= 3
  p 2
elsif a + b >= 3
  p 3
else
  p 4
end
