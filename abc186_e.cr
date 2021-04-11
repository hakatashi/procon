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

def invmod(e, et)
  g, x = extended_gcd(e, et)
  if g != 1
    return nil
  end
  x % et
end

t = read_line.to_i64
t.times do
  n, s, k = read_line.split.map(&.to_i64)
  g, _ = extended_gcd(k, n)
  if g != 1
    if s % g == 0
      n, s, k = n // g, s // g, k // g
    else
      p -1
      next
    end
  end

  inv_k = invmod(k, n)
  if inv_k.nil?
    p -1
  else
    p (n - s) * inv_k % n
  end
end