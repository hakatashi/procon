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
  class PriorityQueue(T)
    property heap : Array(T)

    def initialize
      initialize(&.itself)
    end

    def initialize(&block : T -> (Int8 | Int16 | Int32 | Int64 | UInt8 | UInt16 | UInt32 | UInt64))
      @heap = Array(T).new(1_000_000_i64)
    end

    def push(v : T)
      @heap << v
      index = @heap.size - 1
      while index != 0
        parent = (index - 1) // 2
        if @heap[parent][0] >= @heap[index][0]
          break
        end
        @heap[parent], @heap[index] = @heap[index], @heap[parent]
        index = parent
      end
    end

    def <<(v : T)
      push(v)
    end

    def pop
      if @heap.size == 0
        return nil
      end
      if @heap.size == 1
        return @heap.pop
      end
      ret = @heap.first
      @heap[0] = @heap.pop
      index = 0
      while index * 2 + 1 < @heap.size
        child = if index * 2 + 2 < @heap.size && @heap[index * 2 + 1][0] < @heap[index * 2 + 2][0]
          index * 2 + 2
        else
          index * 2 + 1
        end
        if @heap[index][0] >= @heap[child][0]
          break
        end
        @heap[child], @heap[index] = @heap[index], @heap[child]
        index = child
      end
      ret
    end

    delegate :empty?, to: @heap
    delegate :size, to: @heap
  end
end


n, m = read_line.split.map(&.to_i64)
pres = Array(Array(Tuple(Int64, Int64, Int64))).new(n) { [] of Tuple(Int64, Int64, Int64) }
m.times do
  u, v, c, d = read_line.split.map(&.to_i64)
  pres[u - 1] << {v - 1, c, d}
  pres[v - 1] << {u - 1, c, d}
end

INF = 1_000_000_000_000_000_000_i64

class Dijkstra
  property prever : Array(Int64)
  property pres : Array(Array(Tuple(Int64, Int64, Int64)))
  property n : Int64

  def initialize(@pres, @n)
    @prever = Array(Int64).new(@n, -1_i64)
  end

  def dijkstra(s)
    dist = Array(Int64).new(@n, INF)
    @prever = Array(Int64).new(@n, -1_i64)
    dist[s] = 0_i64

    queue = AtCoder::PriorityQueue(Tuple(Int64, Int64)).new {|(d, v)| d}
    queue << {0_i64, s}

    until queue.empty?
      d, v = queue.pop.not_nil!
      if dist[v] < d
        next
      end

      @pres[v].each do |(to, cost)|
        if dist[to] > dist[v] + cost
          dist[to] = dist[v] + cost
          @prever[to] = v
          queue << {dist[to], to}
        end
      end
    end
  end

  def get_path(t)
    path = Array(Int64).new(1_000_000_i64)
    until t == -1
      path << t
      t = @prever[t]
    end
    path.reverse!
  end
end

dijkstra = Dijkstra.new(pres, n)
dijkstra.dijkstra(0_i64)

"
path = dijkstra.get_path(n - 1)
ans = 0_i64
path.each_cons_pair do |from, to|
  pres[from].each_with_index do |(pre, c, d), i|
    if pre == to
      ans += c
      pres[from][i] = {pre, d, d}
      break
    end
  end
  pres[to].each_with_index do |(pre, c, d), i|
    if pre == from
      pres[to][i] = {pre, d, d}
      break
    end
  end
end

dijkstra.dijkstra(n - 1)
path = dijkstra.get_path(0_i64)
path.each_cons_pair do |from, to|
  pres[from].each_with_index do |(pre, c, d), i|
    if pre == to
      ans += c
      break
    end
  end
end
p ans
"
