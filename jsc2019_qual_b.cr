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
    raise "The maths are broken!"
  end
  x % et
end

MOD = 1000000007_i64

n, k = read_line.split.map(&.to_u64)
ais = read_line.split.map(&.to_u64)
ret = 0_i64
ais.each_with_index do |a, i|
  smallers = ais.count { |a2| a2 < a }
  right_smallers = ais[(i + 1)..-1].count { |a2| a2 < a }
  temp = (k * (k - 1)) % MOD
  temp = (temp * invmod(2_i64, 1000000007_i64)) % MOD
  temp = (temp * smallers) % MOD
  temp2 = (k * right_smallers) % MOD
  ret = (ret + temp) % MOD
  ret = (ret + temp2) % MOD
end
puts ret
