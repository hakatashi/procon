MOD = 998244353_i64

n, s = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)

dp = Array(Int64).new(s + 1, 0_i64)

ans = 0_i64
ais.each_with_index do |a, i|
  if a <= s
    (s - a).downto(1) do |v|
      dp[v + a] = (dp[v + a] + dp[v]) % MOD
    end
    dp[a] = (dp[a] + i.to_i64 + 1) % MOD
  end
  ans = (ans + dp[s]) % MOD
end

p ans