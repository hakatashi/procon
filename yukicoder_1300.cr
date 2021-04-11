lib C;fun strtoll(s: UInt8*,p: UInt8**,b: Int32): Int64;end
class String;def to_i64;C.strtoll(self,nil,10);end;end

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
  class FenwickTree(T)
    getter size : Int64
    getter bits : Array(T)

    def initialize(@size)
      @bits = Array(T).new(@size, T.zero)
    end

    def add(index, value)
      index += 1 # convert to 1-indexed
      while index <= @size
        @bits[index - 1] += value
        index += index & -index
      end
    end

    # Exclusive left sum
    def left_sum(index)
      ret = T.zero
      while index >= 1
        ret += @bits[index - 1]
        index -= index & -index
      end
      ret
    end

    def sum(left, right)
      left_sum(right) - left_sum(left)
    end

    def [](range : Range(Int, Int))
      left = range.begin
      right = range.exclusive? ? range.end : range.end + 1
      sum(left, right)
    end
  end
end

alias Mint = AtCoder::ModInt998244353


gets
ais = read_line.split.map(&.to_i64)

values = ais.uniq.sort!
values_hash = Hash(Int64, Int64).new
values.each_with_index do |v, i|
  values_hash[v] = i.to_i64
end

tree_count_left = AtCoder::FenwickTree(Int64).new(ais.size.to_i64)
tree_sum_left = AtCoder::FenwickTree(Mint).new(ais.size.to_i64)
counts_left = Array(Int64).new(ais.size)
sums_left = Array(Mint).new(ais.size)
sum = 0_i64

ais.each_with_index do |a, i|
  vi = values_hash[a]
  sums_left << sum - tree_sum_left[0..vi]
  counts_left << i.to_i64 - tree_count_left[0..vi]
  tree_count_left.add(vi, 1_i64)
  tree_sum_left.add(vi, a)
  sum += a
end

tree_count_right = AtCoder::FenwickTree(Int64).new(ais.size.to_i64)
tree_sum_right = AtCoder::FenwickTree(Mint).new(ais.size.to_i64)
counts_right = Array(Int64).new(ais.size)
sums_right = Array(Mint).new(ais.size)

ais.reverse_each.with_index do |a, i|
  vi = values_hash[a]
  sums_right << tree_sum_right[0...vi]
  counts_right << tree_count_right[0...vi]
  tree_count_right.add(vi, 1_i64)
  tree_sum_right.add(vi, a)
end

sums_right.reverse!
counts_right.reverse!

ans = Mint.zero

ais.each_with_index do |a, i|
  sum_right = sums_right[i]
  count_right = Mint.new(counts_right[i])
  sum_left = sums_left[i]
  count_left = Mint.new(counts_left[i])
  ans += sum_right * count_left + sum_left * count_right + Mint.new(a) * count_left * count_right
end

p ans
