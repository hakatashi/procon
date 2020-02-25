# -*- mode: float -*-

n, k = read_line.split.map(&.to_i64)
ps = read_line.split.map(&.to_f)

seed = (0...k).map do |i|
  (1.0 + ps[i]) / 2.0
end.sum

max = seed
(k...n).each do |i|
  seed = seed - (1.0 + ps[i - k]) / 2.0 + (1.0 + ps[i]) / 2.0
  if seed > max
    max = seed
  end
end

printf("%.8f\n", max)