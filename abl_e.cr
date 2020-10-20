# ac-library.cr by hakatashi https://github.com/google/ac-library.cr
#
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module AtCoder
  class LazySegTree(S, F)
    getter values : Array(S | Nil)

    def initialize(values : Array(S), @operator : S, S -> S, @application : F, S -> S, @composition : F, F -> F)
      @values = values.map { |v| v.as(S | Nil) }
      segment_size = 2 ** Math.log2(@values.size).ceil.to_i - 1
      @segments = Array(S | Nil).new(segment_size, nil)
      @applicators = Array(F | Nil).new(segment_size, nil)

      # initialize segments
      (@segments.size - 1).downto(0) do |i|
        child1 = nil.as(S | Nil)
        child2 = nil.as(S | Nil)
        if i * 2 + 1 < @segments.size
          child1 = @segments[i * 2 + 1]
          child2 = @segments[i * 2 + 2]
        else
          if i * 2 + 1 - @segments.size < @values.size
            child1 = @values[i * 2 + 1 - @segments.size]
          end
          if i * 2 + 2 - @segments.size < @values.size
            child2 = @values[i * 2 + 2 - @segments.size]
          end
        end
        @segments[i] = operate(child1, child2)
      end
    end

    def []=(index : Int, applicator : F)
      apply_range(index, index + 1, applicator, 0, 0...(@segments.size + 1))
    end

    def []=(range : Range(Int, Int), applicator : F)
      l = range.begin
      r = range.exclusive? ? range.end : range.end + 1
      apply_range(l, r, applicator, 0, 0...(@segments.size + 1))
    end

    def [](index : Int)
      get_range(index, index + 1, 0, 0...(@segments.size + 1)).not_nil!
    end

    def [](range : Range(Int, Int))
      l = range.begin
      r = range.exclusive? ? range.end : range.end + 1
      get_range(l, r, 0, 0...(@segments.size + 1)).not_nil!
    end

    @[AlwaysInline]
    private def operate(a : S | Nil, b : S | Nil)
      if a.nil?
        b
      elsif b.nil?
        a
      else
        @operator.call(a, b)
      end
    end

    @[AlwaysInline]
    private def apply(f : F | Nil, x : S | Nil)
      if f.nil?
        x
      elsif x.nil?
        nil
      else
        @application.call(f, x)
      end
    end

    @[AlwaysInline]
    private def compose(a : F | Nil, b : F | Nil)
      if a.nil?
        b
      elsif b.nil?
        a
      else
        @composition.call(a, b)
      end
    end

    # range must be exclusive
    # assert(segment_index < @segments.size)
    # assert(range.end - range.begin > 1)
    def eval_segment(segment_index : Int, range : Range(Int, Int))
      applicator = @applicators[segment_index]
      return if applicator.nil?

      @segments[segment_index] = apply(applicator, @segments[segment_index])

      if range.end - range.begin > 2
        @applicators[segment_index * 2 + 1] = compose(applicator, @applicators[segment_index * 2 + 1])
        @applicators[segment_index * 2 + 2] = compose(applicator, @applicators[segment_index * 2 + 2])
      else
        @values[segment_index * 2 + 1 - @segments.size] = apply(applicator, @values[segment_index * 2 + 1 - @segments.size])
        @values[segment_index * 2 + 2 - @segments.size] = apply(applicator, @values[segment_index * 2 + 2 - @segments.size])
      end

      @applicators[segment_index] = nil
    end

    # range must be exclusive
    def apply_range(a : Int, b : Int, f : F, segment_index : Int, range : Range(Int, Int))
      if segment_index >= @segments.size + @values.size
        return nil
      end

      if segment_index < @segments.size
        eval_segment(segment_index, range)
      end

      if range.end <= a || b <= range.begin
        if segment_index < @segments.size
          return @segments[segment_index]
        else
          return @values[segment_index - @segments.size]
        end
      end

      if a <= range.begin && range.end <= b
        if segment_index < @segments.size
          @applicators[segment_index] = compose(@applicators[segment_index], f)
          eval_segment(segment_index, range)
          return @segments[segment_index]
        else
          @values[segment_index - @segments.size] = apply(f, @values[segment_index - @segments.size])
          return @values[segment_index - @segments.size]
        end
      end

      range_median = (range.begin + range.end) // 2
      child1 = apply_range(a, b, f, segment_index * 2 + 1, range.begin...range_median)
      child2 = apply_range(a, b, f, segment_index * 2 + 2, range_median...range.end)

      @segments[segment_index] = operate(child1, child2)
      @segments[segment_index]
    end

    # range must be exclusive
    def get_range(a : Int, b : Int, segment_index : Int, range : Range(Int, Int))
      if range.end <= a || b <= range.begin
        return nil
      end

      if segment_index < @segments.size
        eval_segment(segment_index, range)
      end

      if a <= range.begin && range.end <= b
        if segment_index < @segments.size
          return @segments[segment_index]
        else
          return @values[segment_index - @segments.size]
        end
      end

      range_median = (range.begin + range.end) // 2
      child1 = get_range(a, b, segment_index * 2 + 1, range.begin...range_median)
      child2 = get_range(a, b, segment_index * 2 + 2, range_median...range.end)

      operate(child1, child2)
    end

    def all_prod
      self[0...@values.size]
    end
  end
end

# ac-library.cr by hakatashi https://github.com/google/ac-library.cr
#
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module AtCoder
  macro static_modint(name, modulo)
    module AtCoder
      record {{name}}, value : Int64 do
        @@factorials = Array(self).new(100_000_i64) # Change here to improve performance
        MOD = {{modulo}}

        def self.factorial(n)
          if @@factorials.empty?
            @@factorials << self.new(1_i64)
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
          self.new(0_i64)
        end

        def inv
          g, x = self.class.extended_gcd(@value, MOD)
          self.class.new(x % MOD)
        end

        def +(value)
          self.class.new((@value + value.to_i64 % MOD) % MOD)
        end

        def -(value)
          self.class.new((@value + MOD - value.to_i64 % MOD) % MOD)
        end

        def *(value)
          self.class.new((@value * value.to_i64 % MOD) % MOD)
        end

        def /(value : self)
          raise DivisionByZeroError.new if value == 0
          self * value.inv
        end

        def /(value)
          raise DivisionByZeroError.new if value == 0
          self * self.class.new(value.to_i64 % MOD).inv
        end

        def //(value)
          self./(value)
        end

        def **(value)
          b = value > 0 ? self : self.inv
          e = value.abs
          ret = self.class.new(1_i64)
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
          self * self.class.new(2_i64) ** value
        end

        def sqrt
          z = self.class.new(1_i64)
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

        def ==(value : self)
          @value == value.to_i64
        end

        def ==(value)
          @value == value
        end

        def -
          self.class.new(0_i64) - self
        end

        def +
          self
        end

        def abs
          self
        end

        # ac-library compatibility

        def pow(value)
          self.**(value)
        end
        def val
          self.to_i64
        end

        # ModInt shouldn't be compared

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
    end

    struct Int
      def +(value : AtCoder::{{name}})
        value + self
      end

      def -(value : AtCoder::{{name}})
        -value + self
      end

      def *(value : AtCoder::{{name}})
        value * self
      end

      def //(value : AtCoder::{{name}})
        value.inv * self
      end

      def /(value : AtCoder::{{name}})
        self // value
      end

      def ==(value : AtCoder::{{name}})
        value == self
      end
    end
  end
end

AtCoder.static_modint(ModInt1000000007, 1_000_000_007_i64)
AtCoder.static_modint(ModInt998244353, 998_244_353_i64)

alias Mint = AtCoder::ModInt998244353
alias Segment = NamedTuple(val: Mint, size: Int64)

n, q = read_line.split.map(&.to_i64)
ten_pows = Array(Mint).new(1_000_000)
inv9 = Mint.new(9_i64).inv
ret = Mint.new(1_i64)
1_000_000.times do
  ten_pows << ret
  ret *= 10
end

op = ->(a : Segment, b : Segment) { {val: a[:val] * ten_pows[b[:size]] + b[:val], size: a[:size] + b[:size]} }
mapping = ->(f : Mint, x : Segment) { {val: (ten_pows[x[:size]] - 1) * inv9 * f, size: x[:size]} }
composition = ->(a : Mint, b : Mint) { a }
tree = AtCoder::LazySegTree(Segment, Mint).new(Array(Segment).new(n, {val: Mint.new(1_i64), size: 1_i64}), op, mapping, composition)

q.times do
  l, r, d = read_line.split.map(&.to_i64)
  tree[(l - 1)..(r - 1)] = Mint.new(d)
  p tree.all_prod[:val]
end
