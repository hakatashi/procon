n, d = read_line.split.map(&.to_i64)
ans = 0_i64
n.times do
  x, y = read_line.split.map(&.to_i64)
  if x * x + y * y <= d * d
    ans += 1
  end
end
p ans
