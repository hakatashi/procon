a, b, c, k = read_line.split.map(&.to_i64)
if k <= a
  p k
elsif k <= a + b
  p a
else
  p a - (k - (a + b))
end