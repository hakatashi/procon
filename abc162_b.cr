n = read_line.to_i64
ans = 0_i64
1_i64.upto(n) do |i|
  if i % 3 != 0 && i % 5 != 0
    ans += i
  end
end
p ans
