def max(a, b)
  a > b ? a : b
end
def min(a, b)
  a < b ? a : b
end

n, x = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)

ans = 1_000_000_000_000_000_000_i64
ais.size.to_i64.downto(1_i64) do |i|
  dp = Array(Array(Array(Int64))).new(ais.size) { Array(Array(Int64)).new(i + 1) { Array(Int64).new(i, 0_i64) } }
  ais.each_with_index do |a, j|
    dp[j][1][a % i] = max(dp[j][1][a % i], a)
    next if j == 0

    1_i64.upto(i) do |l|
      dp[j - 1][l].each_with_index do |d, k|
        if d != 0
          dp[j][l][k] = max(dp[j][l][k], d)
        end
      end
      dp[j - 1][l - 1].each_with_index do |d, k|
        if d != 0
          dp[j][l - 1][k] = max(dp[j][l - 1][k], d)
          dp[j][l][(k + a) % i] = max(dp[j][l][(k + a) % i], d + a)
        end
      end
    end
  end
  mx = dp.last.last[x % i]
  if mx != 0
    ans = min(ans, (x - mx) // i)
  end
end
p ans
