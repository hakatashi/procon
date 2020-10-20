MOD = 1_000_000_007_i64

def extended_gcd(a, b)
  last_remainder, remainder = a.abs, b.abs
  x, last_x, y, last_y = 0_i64, 1_i64, 1_i64, 0_i64
  while remainder != 0_i64
    new_last_remainder = remainder
    quotient, remainder = last_remainder.divmod(remainder)
    last_remainder = new_last_remainder
    x, last_x = last_x - quotient * x, x
    y, last_y = last_y - quotient * y, y
  end

  return last_remainder, last_x * (a < 0_i64 ? -1_i64 : 1_i64)
end

def invmod(e)
  g, x = extended_gcd(e, MOD)
  x % MOD
end

def pow(b, e)
  ret = 1_i64
  while e > 0
    if e % 2 == 1
      ret = (ret * b) % MOD
    end
    b = (b * b) % MOD
    e = e // 2
  end
  ret
end

r1, c1, r2, c2 = read_line.split.map(&.to_i64)

factorials = Array(Int64).new(2_000_020)
inv_factorials = Array(Int64).new(2_000_020)

factorials << 1_i64
inv_factorials << 1_i64

1_i64.upto(2_000_010_i64) do |i|
  factorials << (factorials[i - 1] * i) % MOD
  inv_factorials << (inv_factorials[i - 1] * invmod(i)) % MOD
end

ans = 0_i64

right_sum = 1_i64
left_sum = pow(2_i64, r1 - 1)

1_i64.upto(r2 + c2) do |i|
  if i > c1
    if i <= c1 + r2
      right = (factorials[i - 1] * inv_factorials[c1 - 1]) % MOD
      right = (right * inv_factorials[i - 1 - c1 + 1]) % MOD
      right_sum = (right_sum * 2 + right) % MOD
    else
      right = (factorials[i - 1] * inv_factorials[r2]) % MOD
      right = (right * inv_factorials[i - 1 - r2]) % MOD
      right_sum = (right_sum * 2 - right) % MOD
    end
  end

  if i > r1 - 1
    if i <= r1 + c2
      left = (factorials[i - 1] * inv_factorials[r1 - 1]) % MOD
      left = (left * inv_factorials[i - 1 - r1 + 1]) % MOD
      left_sum = (left_sum * 2 - left) % MOD
    else
      left = (factorials[i - 1] * inv_factorials[c2]) % MOD
      left = (left * inv_factorials[i - 1 - c2]) % MOD
      left_sum = (left_sum * 2 + left) % MOD
    end
  end

  if i >= r1 + c1
    ans = (ans + right_sum - left_sum + MOD) % MOD
  end
end

p ans
