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

MOD = 1_000_000_007_i64

n, k = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64).sort

facs = Array(Int64).new(n + 2, 1_i64)
n.times do |i|
  facs[i + 1] = (facs[i] * (i + 1)) % MOD
end

ans = 0_i64
all_events = (facs[n] * invmod(facs[n - k])) % MOD
all_events = (all_events * invmod(facs[k])) % MOD

ais.each_cons(2).with_index do |(a, b), i|
  ret = all_events
  if i + 1 >= k
    tmp = (facs[i + 1] * invmod(facs[i + 1 - k])) % MOD
    tmp = (tmp * invmod(facs[k])) % MOD
    ret = (ret - tmp + MOD) % MOD
  end
  if n - i - 1 >= k
    tmp = (facs[n - i - 1] * invmod(facs[n - i - 1 - k])) % MOD
    tmp = (tmp * invmod(facs[k])) % MOD
    ret = (ret - tmp + MOD) % MOD
  end
  tmp = (ret * (b - a)) % MOD
  ans = (ans + tmp) % MOD
end

p ans
