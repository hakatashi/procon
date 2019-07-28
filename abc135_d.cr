cs = read_line.chars.map do |c|
  if c == '?'
    nil
  else
    c.to_u64
  end
end
old_dp = Array(UInt64).new(13, 0_u64)
dp = Array(UInt64).new(13, 0_u64)
dp[0] = 1_u64
cs.each do |c|
  dp.each_with_index do |d, i|
    old_dp[i] = d
    dp[i] = 0_u64
  end
  old_dp.each_with_index do |d, i|
    if c.nil?
      10.times do |j|
        dp[(i * 10 + j) % 13] = (dp[(i * 10 + j) % 13] + d) % 1000000007
      end
    else
      dp[(i * 10 + c) % 13] = (dp[(i * 10 + c) % 13] + d) % 1000000007
    end
  end
end
p dp[5]
