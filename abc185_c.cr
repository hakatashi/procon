l = read_line.to_i64

ans = 1_i64
1_i64.upto(11_i64) do |i|
  ans *= l - i
  ans //= i
end
p ans
