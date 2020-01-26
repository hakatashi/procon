def min(a, b)
  a > b ? b : a
end

def max(a, b)
  a > b ? a : b
end

h, n = read_line.split.map(&.to_i64)
magics = [] of Tuple(Int64, Int64)
n.times do
  a, b = read_line.split.map(&.to_i64)
  magics << {a, b}
end
dp = Array(Int64).new(h + 1, 1_i64 << 60)
dp[0] = 0_i64
h.times do |i|
  magics.each do |(a, b)|
    result = min(i + a, h)
    dp[result] = min(dp[result], dp[i] + b)
  end
end
p dp[h]
