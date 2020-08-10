n = read_line.to_i64
ans = 0_i64
dp = Array(Int64).new(n, 1_i64)
dp.each_with_index do |d, ri|
  i = ri.to_i64 + 1
  if i != 1 && d == 1
    i.step(by: i, to: n) do |j|
      rj = j
      cnt = 0_i64
      until j % i != 0
        j //= i
        cnt += 1
      end
      dp[rj - 1] *= cnt + 1
    end
  end
  ans += i * dp[i - 1]
end
p ans