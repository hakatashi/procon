n = read_line.to_i64 - 1
ans = ""
loop do
  ans = ('a' + n % 26) + ans
  n //= 26
  if n == 0
    break
  end
  n -= 1
end
puts ans
