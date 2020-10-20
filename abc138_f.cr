# -*- status: pending -*-

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

def invmod(e, et)
  g, x = extended_gcd(e, et)
  if g != 1
    raise "The maths are broken!"
  end
  x % et
end

def pow(b : UInt64, e : UInt64)
  mod = 1000000009
  ret = 1_u64
  while e > 0
    if e % 2 == 1
      ret = (ret * b) % mod
    end
    b = (b * b) % mod
    e = e // 2
  end
  ret
end

l, r = read_line.split.map(&.to_u64)
mod = 1000000009

def calc(a_bound : UInt64, b_bound : UInt64)
  mod = 1000000009
  ret = 0_u64
  count = 0_u64
  s = b_bound.to_s(2)
  64.downto(0) do |i|
    if s.size > i && s[-i - 1] == '1'
      ret = (ret + pow(3_u64, i.to_u64 + count.to_u64) - pow(2_u64, i.to_u64) + 1 + mod) % mod
      count += 1
    end
  end
  ret
end

p calc(r, r) - calc(l, l)
