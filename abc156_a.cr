n, r = read_line.split.map(&.to_i64)
if n >= 10
  p r
else
  p r + 100 * (10 - n)
end
