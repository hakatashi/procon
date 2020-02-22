MOD = 1_000_000_007_i64

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
  g, x = extended_gcd(e, MOD)
  x % MOD
end

def pow(b, e)
  ret = 1_u64
  while e > 0
    if e % 2 == 1
      ret = (ret * b) % MOD
    end
    b = (b * b) % MOD
    e = e / 2
  end
  ret
end

facs = Array(Int64).new(1_000_000)
facs << 1_i64
1_i64.upto(1_000_000_i64) do |i|
  facs << (facs.last * i) % MOD
end

n, a, b = read_line.split.map(&.to_i64)
ans = (pow(2_i64, n) - 1_i64 + MOD) % MOD
tmp = 1_i64
1_i64.upto(a) do |i|
  tmp = (tmp * (n - i + 1)) % MOD
  tmp = (tmp * invmod(i)) % MOD
end
ans = (ans + MOD - tmp) % MOD
tmp = 1_i64
1_i64.upto(b) do |i|
  tmp = (tmp * (n - i + 1)) % MOD
  tmp = (tmp * invmod(i)) % MOD
end
ans = (ans + MOD - tmp) % MOD
p ans

