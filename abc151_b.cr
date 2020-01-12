n, k, m = read_line.split.map(&.to_i)
a_sum = read_line.split.map(&.to_i).sum
ans = n * m - a_sum
if ans > k
  p -1
else
  p [ans, 0].max
end