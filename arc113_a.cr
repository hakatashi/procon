k = read_line.to_i64
ans = 0_i64
1_i64.upto(k) do |i|
  max = k // i
  j = 1_i64
  until j * j > max
    ans += (max // j - j) * 2 + 1
    j += 1
  end
end
p ans
