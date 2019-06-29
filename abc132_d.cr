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

n, k = read_line.split(" ").map(&.to_u64)
b, r = k, n - k
k.times do |i|
  k = i + 2
  l = r - i
  if l < 0
    puts 0
    next
  end
  left = k + l - 1
  right = [k - 1, l].min
  ret = 1_u64
  if l != 0
    right.times do |i|
      ret = (ret * (left - i)) % 1000000007
      ret = (ret * invmod(i + 1, 1000000007)) % 1000000007
    end
  end
  left = b - i - 1 + i
  right = [b - i - 1, i].min
  right.times do |i|
    ret = (ret * (left - i)) % 1000000007
    ret = (ret * invmod(i + 1, 1000000007)) % 1000000007
  end
  puts ret
end
