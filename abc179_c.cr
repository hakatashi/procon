n = read_line.to_i64
ans = 0_i64
1_i64.upto(n - 1) do |i|
  ans += (n - 1) // i
end
p ans
