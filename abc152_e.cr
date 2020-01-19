require "big"

MOD = 1_000_000_007_i64.to_big_i

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

gets
ais = read_line.split.map(&.to_big_i)
lcm = (ais.reduce {|a, b| a.lcm(b)} % MOD).to_i64
ans = 0_i64
ais.each do |a|
  tmp = (lcm * invmod(a)) % MOD
  ans = (ans + tmp) % MOD
end
p ans