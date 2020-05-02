x = read_line.to_i64
a = 100_i64
ans = 0_i64
until a >= x
  a = (a * 1.01).floor
  ans += 1
end
p ans
