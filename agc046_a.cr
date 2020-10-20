x = read_line.to_i64
ans = 1_i64
ret = x
until ret == 0
  ans += 1
  ret = (ret + x) % 360
end
p ans
