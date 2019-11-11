dp = {}
dp[1] = 1
minimum = 2
while minimum <= 5e6
  minimum += 1 while dp.has_key?(minimum)
  value = minimum
  history = []
  while dp[value] == nil
    history << value
    if value % 2 == 0
      value = value / 2
    else
      value = value * 3 + 1
    end
  end
  history.reverse.each_with_index do |v, i|
    dp[v] = dp[value] + i + 1
  end
end
max_steps = 0
cursor = 0
1.upto(5e6).map do |i|
  steps = dp[i]
  if max_steps <= steps
    max_steps = steps
    cursor = i
  end
  dp[i] = cursor
end
t = gets.to_i
t.times do
  n = gets.to_i
  p dp[n]
end