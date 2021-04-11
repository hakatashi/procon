n = read_line.to_i64
points = [] of Tuple(Int64, Int64)
n.times do
  x, y = read_line.split.map(&.to_i64)
  points << {x, y}
end
ans = 0_i64
points.each_combination(2) do |(a, b)|
  ax, ay = a
  bx, by = b
  if (ay - by).abs <= (ax - bx).abs
    ans += 1
  end
end
p ans
