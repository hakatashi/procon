n = read_line.to_i64
points = [] of Tuple(Int64, Int64, Int64, Int64)
n.times do
  x, y = read_line.split.map(&.to_i64)
  points << {x, y, x + y, x - y}
end
max_u = points.max_of { |(x, y, u, v)| u }
max_v = points.max_of { |(x, y, u, v)| v }
min_u = points.min_of { |(x, y, u, v)| u }
min_v = points.min_of { |(x, y, u, v)| v }
candidates = [
  points.select { |(x, y, u, v)| u == max_u }.max_by { |(x, y, u, v)| v },
  points.select { |(x, y, u, v)| u == max_u }.min_by { |(x, y, u, v)| v },
  points.select { |(x, y, u, v)| v == max_v }.max_by { |(x, y, u, v)| u },
  points.select { |(x, y, u, v)| v == max_v }.min_by { |(x, y, u, v)| u },
  points.select { |(x, y, u, v)| u == min_u }.max_by { |(x, y, u, v)| v },
  points.select { |(x, y, u, v)| u == min_u }.min_by { |(x, y, u, v)| v },
  points.select { |(x, y, u, v)| v == min_v }.max_by { |(x, y, u, v)| u },
  points.select { |(x, y, u, v)| v == min_v }.min_by { |(x, y, u, v)| u },
]
ans = candidates.each_combination(2).max_of do |(a, b)|
  ax, ay, au, av = a
  bx, by, bu, bv = b
  (ax - bx).abs + (ay - by).abs
end
p ans
