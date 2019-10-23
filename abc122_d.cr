n = read_line.to_i
dp = Array.new(n - 2) { Hash(Array(Char), Int64).new(0_i64) }
Array.each_product([['A', 'T', 'G', 'C']] * 3) do |product|
  unless product == ['A', 'G', 'C'] || product == ['G', 'A', 'C'] || product == ['A', 'C', 'G']
    dp[0][product] = 1_i64
  end
end
(n - 3).times do |i|
  ['A', 'T', 'G', 'C'].each do |n|
    dp[i].each do |k, v|
      unless (
        (k[0] == 'A' && k[2] == 'G' && n == 'C') ||
        (k[0] == 'A' && k[1] == 'G' && n == 'C') ||
        (k[1] == 'A' && k[2] == 'G' && n == 'C') ||
        (k[1] == 'G' && k[2] == 'A' && n == 'C') ||
        (k[1] == 'A' && k[2] == 'C' && n == 'G')
      )
        dp[i + 1][[k[1], k[2], n]] = (dp[i + 1][[k[1], k[2], n]] + v) % 1000000007
      end
    end
  end
end
p dp[n - 3].values.sum % 1000000007