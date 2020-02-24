record ModNum, value : Int64 do
  @@factorials = Array(ModNum).new(100_000_i64) # Change here to improve performance

  def self.permutation(n, k)
    if @@factorials.empty?
      @@factorials << ModNum.new(1_i64)
    end
    @@factorials.size.upto(n) do |i|
      @@factorials << @@factorials.last * i
    end

    @@factorials[n] / @@factorials[n - k]
  end

  def self.combination(n, k)
    permutation(n, k) / @@factorials[k]
  end

  def self.repeated_combination(n, k)
    combination(n + k - 1, k)
  end

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

  def inv
    g, x = extended_gcd(@value, MOD)
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
    self * value.inv
  end

  def /(value)
    self * ModNum.new(value.to_i64 % MOD).inv
  end

  def **(value)
    b = self
    e = value.to_i64
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
    r
  end

  def to_i64
    @value
  end

  def ==(value)
    @value == value.to_i64
  end

  def !=(value)
    @value != value.to_i64
  end

  def to_s
    @value.to_s
  end

  def inspect
    @value.inspect
  end

  def abs
    self
  end
end