def extended_gcd(a, b)
  last_remainder, remainder = a.abs, b.abs
  x, last_x, y, last_y = 0_i64, 1_i64, 1_i64, 0_i64
  while remainder != 0
    new_last_remainder = remainder
    quotient, remainder = last_remainder.divmod(remainder)
    last_remainder = new_last_remainder
    x, last_x = last_x - quotient * x, x
    y, last_y = last_y - quotient * y, y
  end

  return last_remainder, last_x * (a < 0 ? -1 : 1)
end

a, b = read_line.split.map(&.to_i64)
gcd, _ = extended_gcd(a, b)
ret = 1_i64
i = 2_i64
while i * i <= gcd
  if gcd % i == 0
    ret += 1
    while gcd % i == 0
      gcd = gcd // i
    end
  end
  i += 1
end
if gcd > 1
  ret += 1
end
p ret
