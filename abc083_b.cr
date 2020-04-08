# -*- contest: language-test-202001 -*-

n, a, b = read_line.split.map(&.to_i64)
ans = (1..n).select do |i|
  ret = i.to_s.chars.map(&.to_i).sum
  a <= ret && ret <= b
end
p ans.sum
