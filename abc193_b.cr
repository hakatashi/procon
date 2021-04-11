n = read_line.to_i64
ans = -1_i64
n.times do
  a, p, x = read_line.split.map(&.to_i64)
  if x - a > 0
    if ans > p || ans == -1
      ans = p
    end
  end
end
p ans