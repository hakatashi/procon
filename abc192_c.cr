def f(n)
  g1 = n.to_s.chars.sort!
  g2 = g1.reverse
  g2.join.to_i - g1.join.to_i
end

n, k = read_line.split.map(&.to_i64)
k.times do
  n = f(n)
end
p n
