def product_overflow?(a, b)
  a.to_s(2).size + b.to_s(2).size > 64
end


x, y, a, b = read_line.split.map(&.to_i64)
str = x
ans = 0_i64
while !product_overflow?(str, a - 1) && str * (a - 1) < b && str < y
  str *= a
  ans += 1
end
ans += (y - str - 1) // b
p ans
