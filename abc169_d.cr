n = read_line.to_i64
d = 2_i64
ans = 0_i64
until n < d * d
  fac = 0_i64
  while n % d == 0
    n //= d
    fac += 1
  end
  fac2 = 0_i64
  until fac2 * (fac2 + 1) // 2 > fac
    fac2 += 1
  end
  ans += fac2 - 1
  d += 1
end
if n != 1
  ans += 1
end
p ans
