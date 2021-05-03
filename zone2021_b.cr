# -*- mode: float -*-
n, d1, h1 = read_line.split.map(&.to_i64)
ans = 0.0_f64
n.times do
  d2, h2 = read_line.split.map(&.to_i64)
  h3 = h1 - (h1 - h2) / (d1 - d2) * d1
  if h3 > ans
    ans = h3
  end
end
p ans