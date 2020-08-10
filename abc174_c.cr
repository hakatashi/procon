k = read_line.to_i64
ret = 7_i64
ans = 1_i64
until ret == 7_i64 % k && ans > 1
  ret = (ret * 10 + 7) % k
  ans += 1
  if ret == 0
    p ans
    exit
  end
end
p -1