TWO  = 2_i64
ONE  = 1_i64
ZERO = 0_i64

MOD = 1000000007_i64

def pow(b, e)
  ret = ONE
  while e > 0
    if e % 2 == 1
      ret = (ret * b) % MOD
    end
    b = (b * b) % MOD
    e = e // 2
  end
  ret
end

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
  if g != 1
    raise "The maths are broken!"
  end
  x % MOD
end

n = read_line.to_i64
pres = Array(Array(Int64)).new(n) { [] of Int64 }
(n - 1).times do |i|
  a, b = read_line.split.map(&.to_i64)
  pres[a - 1] << b - 1
  pres[b - 1] << a - 1
end

stack = Deque(Int64).new
stack << 0_i64
visited = Set(Int64).new
visited << 0_i64
sorted_nodes = Array(Tuple(Int64, Int64)).new
sorted_nodes << {0_i64, -1_i64}
until stack.empty?
  node = stack.pop
  count = 1_i64
  pres[node].each do |child|
    next if visited.includes?(child)
    sorted_nodes << {child, node}
    stack << child
    visited << child
  end
end

dp = Array(Int64).new(n, 0_i64)
dp2 = Array(Int64).new(n, 0_i64)

sorted_nodes.reverse_each do |(node, parent)|
  count = 1_i64
  pres[node].each do |child|
    next if child == parent
    count += dp[child]
  end

  dp[node] = count

  values = [n - count]
  pres[node].each do |child|
    next if child == parent
    values << dp[child]
  end

  if values.size <= 1
    possibility = ZERO
  else
    possibility = pow(TWO, n - 1) # whole events

    # subtract the possibility where none of the branches contains black node
    possibility -= ONE

    # subtract the possibility where one of the branches contains black node
    values.each do |value|
      possibility = (possibility - pow(TWO, value) + ONE + MOD) % MOD
    end
  end

  ret = possibility

  pres[node].each_with_index do |child, i|
    next if child == parent
    ret = (ret + dp2[child]) % MOD
  end

  dp2[node] = ret
end

ans = dp2[0]
p (ans * invmod(pow(TWO, n))) % MOD
