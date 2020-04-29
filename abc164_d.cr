s = read_line.chars
dp = [
  Array(Int64).new(2019, 0_i64),
  Array(Int64).new(2019, 0_i64),
]
ans = 0_i64
s.each_with_index do |c, i|
  d = c.to_i64
  dp[i % 2].each_with_index do |v, j|
    dp[(i + 1) % 2][(j * 10 + d) % 2019] = v
  end
  dp[(i + 1) % 2][d] += 1
  ans += dp[(i + 1) % 2][0]
end
p ans
