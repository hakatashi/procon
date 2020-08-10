# ModNum.cr by Koki Takahashi
# Licensed under MIT License https://mit-license.org

record ModNum, value : Int64 do
  @@factorials = Array(ModNum).new(100_000_i64) # Change here to improve performance

  def self.factorial(n)
    if @@factorials.empty?
      @@factorials << ModNum.new(1_i64)
    end
    @@factorials.size.upto(n) do |i|
      @@factorials << @@factorials.last * i
    end
    @@factorials[n]
  end

  def self.permutation(n, k)
    raise ArgumentError.new("k cannot be greater than n") unless n >= k
    factorial(n) // factorial(n - k)
  end

  def self.combination(n, k)
    raise ArgumentError.new("k cannot be greater than n") unless n >= k
    permutation(n, k) // @@factorials[k]
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

  def self.zero
    ModNum.new(0_i64)
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
    raise DivisionByZeroError.new if value == 0
    self * value.inv
  end

  def /(value)
    raise DivisionByZeroError.new if value == 0
    self * ModNum.new(value.to_i64 % MOD).inv
  end

  def //(value)
    self./(value)
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
      e //= 2
    end
    ret
  end

  def <<(value)
    self * ModNum.new(2_i64) ** value
  end

  def sqrt
    z = ModNum.new(1_i64)
    until z ** ((MOD - 1) // 2) == MOD - 1
      z += 1
    end
    q = MOD - 1
    m = 0
    while q % 2 == 0
      q //= 2
      m += 1
    end
    c = z ** q
    t = self ** q
    r = self ** ((q + 1) // 2)
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

  delegate to_s, to: @value
  delegate inspect, to: @value
end


MOD = 1_000_000_007_i64
n, k = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)

if n == k
  ans = ais.map {|n| ModNum.new(n)}.reduce(ModNum.new(1_i64)) {|a, b| a * b}
  p ans
  exit
end

poss = Array(Int64).new
negs = Array(Int64).new
zeros = Array(Int64).new
ais.each do |a|
  if a > 0
    poss << a
  elsif a == 0
    zeros << a
  else
    negs << a
  end
end

poss.sort!.reverse!
negs.sort!
if zeros.size == 0 && poss.size == 0 && k.odd?
  ans = negs.reverse![...k].map {|n| ModNum.new(n)}.reduce(ModNum.new(1_i64)) {|a, b| a * b}
  p ans
  exit
end
if poss.size == 0 && k.odd?
  p 0
  exit
end
if zeros.size + k > n
  p 0
  exit
end
if zeros.size + k == n && negs.size.odd?
  p 0
  exit
end

ans = ModNum.new(1_i64)
pos_ptr = 0_i64
neg_ptr = 0_i64
if k.odd?
  ans *= poss[0]
  pos_ptr += 1
end
until pos_ptr + 1 >= poss.size || pos_ptr + 2 > k
  ans *= poss[pos_ptr]
  ans *= poss[pos_ptr + 1]
  pos_ptr += 2
end
until pos_ptr + neg_ptr == k
  ans *= negs[neg_ptr]
  ans *= negs[neg_ptr + 1]
  neg_ptr += 2
end

until pos_ptr - 2 < 0 || neg_ptr + 1 >= negs.size
  dec = poss[pos_ptr - 1] * poss[pos_ptr - 2]
  inc = negs[neg_ptr] * negs[neg_ptr + 1]
  break unless dec <= inc
  ans /= dec % MOD
  ans *= inc % MOD
  pos_ptr -= 2
  neg_ptr += 2
end

p ans