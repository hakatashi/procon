def extended_gcd(a, b)
  last_remainder, remainder = a.abs, b.abs
  x, last_x, y, last_y = 0, 1, 1, 0
  while remainder != 0
    new_last_remainder = remainder
    quotient, remainder = last_remainder.divmod(remainder)
    last_remainder = new_last_remainder
    x, last_x = last_x - quotient * x, x
    y, last_y = last_y - quotient * y, y
  end

  return last_remainder, last_x * (a < 0 ? -1 : 1)
end

def invmod(e)
  g, x = extended_gcd(e, 1000000007_i64)
  if g != 1
    raise "The maths are broken!"
  end
  x % 1000000007_i64
end

def factorial(n)
  ret = 1_i64
  n.times do |i|
    ret = (ret * (i + 1)) % 1000000007_i64
  end
  ret
end

x, y = read_line.split.map(&.to_i64)
if (x + y) % 3 != 0
  p 0
  exit
end
depth = ((x + y) // 3_i64).to_i64
if x < depth || y < depth
  p 0
  exit
end
ret = factorial(depth)
ret = (ret * invmod(factorial(x - depth))) % 1000000007_i64
ret = (ret * invmod(factorial(y - depth))) % 1000000007_i64
p ret
