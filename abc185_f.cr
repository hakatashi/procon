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
  class SegTree(T)
    property values : Array(T)

    def initialize(values : Array(T))
      initialize(values) {|a, b| a > b ? a : b}
    end

    def initialize(values : Array(T), &@operator : T, T -> T)
      @values = values
      @segments = Array(T | Nil).new(2 ** Math.log2(values.size).ceil.to_i - 1, nil)

      # initialize segments
      (@segments.size - 1).downto(0) do |i|
        child1 = nil.as(T | Nil)
        child2 = nil.as(T | Nil)
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

    @[AlwaysInline]
    private def operate(a : T | Nil, b : T | Nil)
      if a.nil?
        b
      elsif b.nil?
        a
      else
        @operator.call(a, b)
      end
    end

    def []=(index : Int, value : T)
      @values[index] = value

      parent_index = (index + @segments.size - 1) // 2
      while parent_index >= 0
        i = parent_index
        child1 = nil.as(T | Nil)
        child2 = nil.as(T | Nil)
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
        parent_index = (parent_index - 1) // 2
      end
    end

    def [](index : Int)
      @values[index]
    end

    def [](range : Range(Int, Int))
      a = range.begin
      b = range.exclusive? ? range.end : range.end + 1
      get_value(a, b, 0, 0...(@segments.size + 1)).not_nil!
    end

    def get_value(a : Int, b : Int, segment_index : Int, range : Range(Int, Int))
      if range.end <= a || b <= range.begin
        return nil
      end

      if a <= range.begin && range.end <= b
        if segment_index < @segments.size
          return @segments[segment_index]
        else
          return @values[segment_index - @segments.size]
        end
      end

      range_median = (range.begin + range.end) // 2
      child1 = get_value(a, b, 2 * segment_index + 1, range.begin...range_median)
      child2 = get_value(a, b, 2 * segment_index + 2, range_median...range.end)

      operate(child1, child2)
    end

    # compatibility with ac-library

    def set(index : Int, value : T)
      self.[]=(index, value)
    end

    def get(index : Int)
      self.[](index)
    end

    def prod(left : Int, right : Int)
      self.[](left...right)
    end

    def all_prod
      self.[](0...@values.size)
    end
  end
end

n, q = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)

tree = AtCoder::SegTree.new(ais) {|a, b| a ^ b}
q.times do
  t, x, y = read_line.split.map(&.to_i64)
  if t == 1
    tree[x - 1] ^= y
  else
    p tree[(x - 1)..(y - 1)]
  end
end
