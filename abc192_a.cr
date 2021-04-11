x = read_line.to_i64
d = x % 100
if d == 0
  p 100
else
  p 100 - d
end