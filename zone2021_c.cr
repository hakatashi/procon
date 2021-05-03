n = read_line.to_i64
vss = [] of Array(Int64)
n.times do
  vs = read_line.split.map(&.to_i64)
  vss << vs
end
# 不能ならtrue
ans = (0_i64..1_000_000_000_000_i64).bsearch do |i|
  dp = Array(Int64).new(1 << 5, 1_000_000_i64)
  dp[0] = 0_i64
  vss.each do |vs|
    pattern = 0_i64
    vs.each_with_index do |v, j|
      if v >= i
        pattern |= 1_i64 << j
      end
    end
    (1 << 5).times do |pattern_before|
      if dp[pattern_before] != 1_000_000_i64 && dp[pattern_before | pattern] > dp[pattern_before] + 1
        dp[pattern_before | pattern] = dp[pattern_before] + 1
      end
    end
  end
  dp[0b11111] > 3
end
p ans.not_nil! - 1
