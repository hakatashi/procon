digits = read_line.chars.map(&.to_i64).reverse
sum = 0_i64
dp = [0_i64, 2_i64]
digits.each_with_index do |digit, i|
  sum += digit
  overs = [] of Int64
  non_overs = [] of Int64
  non_overs << sum
  non_overs << (digit == 9 ? 1_000_000_000_000_i64 : (dp[1] + digit))
  overs << dp[1] + 10 - digit - 1
  non_overs << sum
  overs << dp[0] + 10 - digit + 1
  overs << (i.to_i64 + 1) * 9 - sum + 2
  non_overs << dp[0] + digit
  non_overs << i.to_i64 * 9 - (sum - digit) + 1 + digit + 1
  dp[0] = non_overs.min
  dp[1] = overs.min
end
p dp.min
