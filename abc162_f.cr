def max(a, b)
  a > b ? a : b
end

INF = 1_000_000_000_000_000_000_i64
n = read_line.to_i64
ais = read_line.split.map(&.to_i64)
a0, a1, a2, b0, b1, b2 = 0_i64, -INF, -INF, 0_i64, -INF, -INF
ais.each_with_index do |a, i|
  a0, a1, a2, b0, b1, b2 = b0, max(a0, b1), max(a1, b2), a0 + a, a1 + a, a2 + a
end
if n % 2 == 0
  p max(a0, b1)
else
  p max(a1, b2)
end
