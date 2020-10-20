def max(a, b)
  a > b ? a : b
end

n, t = read_line.split.map(&.to_i)
dishes = [] of Tuple(Int32, Int32)
n.times do
  a, b = read_line.split.map(&.to_i)
  dishes << {a, b}
end
dp = [Array(Int32).new(t, 0), Array(Int32).new(t, 0)]
dishes.each do |(a, b)|
  dp[1].reverse_each.each_with_index do |s, i|
    time = t - i - 1
    if time + a <= t - 1
      dp[1][time + a] = max(dp[1][time + a], s + b)
    end
  end
  dp[0].reverse_each.each_with_index do |s, i|
    time = t - i - 1
    dp[1][time] = max(dp[1][time], s + b)
  end
  dp[0].reverse_each.each_with_index do |s, i|
    time = t - i - 1
    if time + a <= t - 1
      dp[0][time + a] = max(dp[0][time + a], s + b)
    end
  end
end
p max(dp[0].max, dp[1].max)
