def max(a, b)
  a > b ? a : b
end

n = read_line.to_i64
ais = read_line.split.map(&.to_i64)
vals = ais.map_with_index {|a, loc| {loc.to_i64, a}}.sort_by! {|(loc, a)| a}.reverse!
dp = Array(Array(Int64)).new(n + 1) { Array(Int64).new(n + 1, 0_i64) }
vals.each_with_index do |(loc, a), i|
  remains = vals.size.to_i64 - i
  dp[i].each_with_index do |v, j|
    left = j.to_i64
    right = j.to_i64 + remains - 1

    next if right >= n
    dp[i + 1][j + 1] = max(dp[i + 1][j + 1], v + (left - loc).abs * a)
    dp[i + 1][j] = max(dp[i + 1][j], v + (right - loc).abs * a)
  end
end
p dp[vals.size].max
