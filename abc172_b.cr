s = read_line.chars
t = read_line.chars
ans = 0_i64
s.zip(t).each do |(a, b)|
  if a != b
    ans += 1
  end
end
p ans
