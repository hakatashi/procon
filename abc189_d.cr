n = read_line.to_i64
dp = {
  Array(Int64).new(n + 1, 0_i64),
  Array(Int64).new(n + 1, 0_i64),
}
dp[0][0] = 1_i64
dp[1][0] = 1_i64

n.times do |i|
  s = read_line
  if s == "AND"
    dp[0][i + 1] = dp[0][i] * 2 + dp[1][i]
    dp[1][i + 1] = dp[1][i]
  else
    dp[0][i + 1] = dp[0][i]
    dp[1][i + 1] = dp[1][i] * 2 + dp[0][i]
  end
end
p dp[1][n]


