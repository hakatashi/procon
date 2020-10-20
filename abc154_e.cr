n = read_line
k = read_line.to_i64
dp = Array(Array(Int64)).new(101) { [0_i64, 0_i64, 0_i64, 0_i64] }
dp[0][0] = 1_i64

1.upto(100) do |i|
  dp[i][0] = dp[i - 1][0]
  dp[i][1] = dp[i - 1][1] + dp[i - 1][0] * 9
  dp[i][2] = dp[i - 1][2] + dp[i - 1][1] * 9
  dp[i][3] = dp[i - 1][3] + dp[i - 1][2] * 9
end

ans = 0_i64

non_zeros = 0_i64

n.chars.each_with_index do |ds, ri|
  d = ds.to_i64
  i = n.size - ri
  if i == 1
    if k - non_zeros == 0
      ans += 1
    elsif k - non_zeros == 1
      ans += d
    end
  elsif d != 0
    if k - non_zeros == 0
      ans += dp[i - 1][0]
    elsif k - non_zeros == 1
      ans += dp[i - 1][1] + (d - 1)
    elsif k - non_zeros == 2
      ans += dp[i - 1][2] + dp[i - 1][1] * (d - 1)
    elsif k - non_zeros == 3
      ans += dp[i - 1][3] + dp[i - 1][2] * (d - 1)
    end
  end
  if d != 0
    non_zeros += 1
  end
end

p ans
