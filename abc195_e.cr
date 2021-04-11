n = read_line.to_i64
ss = read_line.chars
ts = read_line.chars

dp = Array(Bool).new(7_i64, false)
dp[0] = true

reg = 5_i64

ss.zip(ts).reverse_each.with_index do |(rs, t), i|
  new_dp = Array(Bool).new(7_i64, false)
  reg = (reg * 10) % 7
  s = rs.to_i64 * reg
  if t == 'A'
    7_i64.times do |i|
      if dp[i] == false || dp[(i + s) % 7] == false
        new_dp[i] = false
      else
        new_dp[i] = true
      end
    end
  else
    7_i64.times do |i|
      if dp[i] == true || dp[(i + s) % 7] == true
        new_dp[i] = true
      else
        new_dp[i] = false
      end
    end
  end
  dp = new_dp
end
puts dp[0] ? "Takahashi" : "Aoki"
