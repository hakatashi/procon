def max(a, b)
  a > b ? a : b
end
def min(a, b)
  a < b ? a : b
end

n, k = read_line.split.map(&.to_i64)
if k < 0
  k = -k
end

ans = 0_i64
(n * 2).downto(k + 2) do |i|
  upper = min(n, i - 1) - max(1_i64, i - n) + 1
  downer = min(n, i - k - 1) - max(1_i64, i - k - n) + 1
  ans += upper * downer
end
p ans
