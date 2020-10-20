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

n, k = read_line.split.map(&.to_i64)

facs = Array(Int64).new(500_100_i64)
facs << 1_i64
1_i64.upto(500_000_i64) do |i|
  facs << (facs.last * i) % MOD
end

ans = (facs[2 * n - 1] * invmod(facs[n])) % MOD
ans = (ans * invmod(facs[n - 1])) % MOD

(n - 1).downto(k + 1) do |i|
  tmp = (facs[n] * invmod(facs[n - i])) % MOD
  tmp = (tmp * invmod(facs[i])) % MOD
  tmp = (tmp * facs[n - 1]) % MOD
  tmp = (tmp * invmod(facs[i])) % MOD
  tmp = (tmp * invmod(facs[n - i - 1])) % MOD
  ans = (ans + MOD - tmp) % MOD
end

p ans
