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

  return last_remainder, last_x * (a < 0 ? -1 : 1), last_y * (b < 0 ? -1 : 1)
end

def factorize(n)
  i = 2_i64
  h = Hash(Int64, Int64).new(0_i64)
  until i * i > n
    if n % i == 0
      n = n // i
      h[i] += 1
    else
      i += 1
    end
  end
  if n > 1
    h[n] += 1
  end
  h
end

n = read_line.to_i64
factors = factorize(n * 2)
fs = factors.to_a.map { |n, x| n ** x }
ans = 1_000_000_000_000_000_000_i64
Array.each_product([[false, true]] * fs.size) do |prod|
  a = 1_i64
  b = 1_i64
  prod.each_with_index do |t, i|
    if t
      a *= fs[i]
    else
      b *= fs[i]
    end
  end
  gcd, x, y = extended_gcd(a, -b)
  y = y % a
  if y == 0
    y = a
  end
  ret = y * b
  if ret < ans
    ans = ret
  end
end
p ans
