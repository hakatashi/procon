n = read_line.to_i64
if n % 2 == 0
  ret = 0_i64
  i = 10_i64
  until i > n
    ret += n // i
    i *= 5_i64
  end
  p ret
else
  p 0
end
