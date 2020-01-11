gets
s = read_line.chars
ans = 0
s.each_cons(3) do |(a, b, c)|
  if a == 'A' && b == 'B' && c == 'C'
    ans += 1
  end
end
p ans