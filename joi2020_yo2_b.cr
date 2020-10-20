# -*- contest: joi2020yo2 -*-

n = read_line.to_i
ans = n.times.max_of do
  a, t = read_line.split.map(&.to_i)
  [a * 2, a + t].max
end
p ans
