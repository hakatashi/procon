# -*- contest: past202005-open -*-

def min(a, b, c, d)
  min(a, min(b, min(c, d)))
end
def min(a, b)
  a > b ? b : a
end

n, l = read_line.split.map(&.to_i64)
xs = read_line.split.map(&.to_i64).to_set
t1, t2, t3 = read_line.split.map(&.to_i64)

dp = Array(Int64).new(l + 100, 1_000_000_000_000_i64)
dp[0] = 0_i64
l.times do |i|
  dp[i + 1] = min(dp[i + 1], dp[i] + t1 + (xs.includes?(i + 1) ? t3 : 0))
  dp[i + 2] = min(dp[i + 2], dp[i] + t1 + t2 + (xs.includes?(i + 2) ? t3 : 0))
  dp[i + 4] = min(dp[i + 4], dp[i] + t1 + t2 * 3 + (xs.includes?(i + 4) ? t3 : 0))
end

ans = min(
  dp[l],
  dp[l - 1] + t1 // 2 + t2 // 2,
  dp[l - 2] + t1 // 2 + t2 // 2 * 3,
  dp[l - 3] + t1 // 2 + t2 // 2 * 5,
)
p ans
