# -*- mode: float -*-

a, b, c = read_line.split.map(&.to_i64)
init_sum = a + b + c
dp = Hash(Tuple(Int64, Int64, Int64), Float64).new(0.0_f64)
tour = Array(Tuple(Int64, Int64, Int64)).new(1_000_000)
100_i64.times do |a|
  100_i64.times do |b|
    100_i64.times do |c|
      tour << {a, b, c}
    end
  end
end
dp[{a, b, c}] = 1.0_f64
ans = 0.0_f64
tour.sort_by! {|(a, b, c)| a + b + c}
tour.each do |(a, b, c)|
  key = {a, b, c}
  if dp.has_key?(key)
    if a + 1 == 100
      ans += (a + b + c + 1 - init_sum) * dp[key] * a / (a + b + c)
    else
      dp[{a + 1, b, c}] += dp[key] * a / (a + b + c)
    end
    if b + 1 == 100
      ans += (a + b + c + 1 - init_sum) * dp[key] * b / (a + b + c)
    else
      dp[{a, b + 1, c}] += dp[key] * b / (a + b + c)
    end
    if c + 1 == 100
      ans += (a + b + c + 1 - init_sum) * dp[key] * c / (a + b + c)
    else
      dp[{a, b, c + 1}] += dp[key] * c / (a + b + c)
    end
  end
end
p ans
