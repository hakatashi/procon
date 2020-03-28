# ModNum.cr by Koki Takahashi
# Licensed under MIT License https://mit-license.org

record ModNum, value : Int64 do
  @@factorials = Array(ModNum).new(100_000_i64) # Change here to improve performance

  def self.permutation(n, k)
    raise ArgumentError.new("k cannot be greater than n") unless n >= k
    if @@factorials.empty?
      @@factorials << ModNum.new(1_i64)
    end
    @@factorials.size.upto(n) do |i|
      @@factorials << @@factorials.last * i
    end

    @@factorials[n] / @@factorials[n - k]
  end

  def self.factorial(n)
    permutation(n, n)
  end

  def self.combination(n, k)
    raise ArgumentError.new("k cannot be greater than n") unless n >= k
    permutation(n, k) / @@factorials[k]
  end

  def self.repeated_combination(n, k)
    combination(n + k - 1, k)
  end

  def self.extended_gcd(a, b)
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

  def inv
    g, x = ModNum.extended_gcd(@value, MOD)
    ModNum.new(x % MOD)
  end

  def +(value)
    ModNum.new((@value + value.to_i64 % MOD) % MOD)
  end

  def -(value)
    ModNum.new((@value + MOD - value.to_i64 % MOD) % MOD)
  end

  def *(value)
    ModNum.new((@value * value.to_i64 % MOD) % MOD)
  end

  def /(value : ModNum)
    raise DivisionByZero.new if value == 0
    self * value.inv
  end

  def /(value)
    raise DivisionByZero.new if value == 0
    self * ModNum.new(value.to_i64 % MOD).inv
  end

  def **(value)
    b = value > 0 ? self : self.inv
    e = value.abs
    ret = ModNum.new(1_i64)
    while e > 0
      if e % 2 == 1
        ret *= b
      end
      b *= b
      e /= 2
    end
    ret
  end

  def <<(value)
    self * ModNum.new(2_i64) ** value
  end

  def sqrt
    z = ModNum.new(1_i64)
    until z ** ((MOD - 1) / 2) == MOD - 1
      z += 1
    end
    q = MOD - 1
    m = 0
    while q % 2 == 0
      q /= 2
      m += 1
    end
    c = z ** q
    t = self ** q
    r = self ** ((q + 1) / 2)
    m.downto(2) do |i|
      tmp = t ** (2 ** (i - 2))
      if tmp != 1
        r *= c
        t *= c ** 2
      end
      c *= c
    end
    if r * r == self
      r.to_i64 * 2 <= MOD ? r : -r
    else
      nil
    end
  end

  def to_i64
    @value
  end

  def ==(value : ModNum)
    @value == value.to_i64
  end

  def ==(value)
    @value == value
  end

  def -
    ModNum.new(0_i64) - self
  end

  def +
    self
  end

  def abs
    self
  end

  # ModNum shouldn't be compared
  def <(value)
    raise NotImplementedError.new("<")
  end
  def <=(value)
    raise NotImplementedError.new("<=")
  end
  def <(value)
    raise NotImplementedError.new("<")
  end
  def >=(value)
    raise NotImplementedError.new(">=")
  end

  def to_s
    @value.to_s
  end

  def inspect
    @value.inspect
  end
end


MOD = 1_000_000_007_i64

n = read_line.to_i64
pres = Array(Array(Int64)).new(n) { [] of Int64 }
(n - 1).times do |i|
  a, b = read_line.split.map(&.to_i64)
  pres[a - 1] << b - 1
  pres[b - 1] << a - 1
end

def dfs(node, parent, pres, dp)
  ans = ModNum.new(1_i64)
  count_sum = 0_i64
  pres[node].each do |child|
    next if child == parent
    dfs(child, node, pres, dp)
    count, pattern = dp[child].not_nil!
    ans *= pattern
    count_sum += count
  end
  ans *= ModNum.factorial(count_sum)
  pres[node].each do |child|
    next if child == parent
    count, pattern = dp[child].not_nil!
    ans /= ModNum.factorial(count)
  end
  dp[node] = {count_sum + 1, ans}
end

dp = Array(Tuple(Int64, ModNum) | Nil).new(n, nil)
dfs(0_i64, -1_i64, pres, dp)

def dfs2(node, parent, pres, dp, anss, dp_par)
  par_count, par_pattern = dp_par
  ans = par_pattern
  count_sum = par_count
  pres[node].each do |child|
    next if child == parent
    count, pattern = dp[child].not_nil!
    ans *= pattern
    count_sum += count
  end
  factor = ModNum.factorial(par_count)
  pres[node].each do |child|
    next if child == parent
    count, pattern = dp[child].not_nil!
    factor *= ModNum.factorial(count)
  end
  anss[node] = ans * ModNum.factorial(count_sum) / factor
  pres[node].each do |child|
    next if child == parent
    count, pattern = dp[child].not_nil!
    dfs2(child, node, pres, dp, anss, {count_sum - count + 1, ModNum.factorial(count_sum - count) * ans / factor * ModNum.factorial(count) / pattern})
  end
end

anss = Array(ModNum).new(n, ModNum.new(1_i64))
dfs2(0_i64, -1_i64, pres, dp, anss, {0_i64, ModNum.new(1_i64)})

anss.each do |ans|
  p ans
end