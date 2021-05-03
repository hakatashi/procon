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
      @heap = Array(T).new
      @priority_proc = block
    end

    def push(v : T)
      @heap << v
      index = @heap.size - 1
      while index != 0
        parent = (index - 1) // 2
        if @priority_proc.call(@heap[parent]) >= @priority_proc.call(@heap[index])
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
        child = if index * 2 + 2 < @heap.size && @priority_proc.call(@heap[index * 2 + 1]) < @priority_proc.call(@heap[index * 2 + 2])
          index * 2 + 2
        else
          index * 2 + 1
        end
        if @priority_proc.call(@heap[index]) >= @priority_proc.call(@heap[child])
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


r, c = read_line.split.map(&.to_i64)
pres = Array(Array(Tuple(Int64, Int64))).new(r * c * 2) { Array(Tuple(Int64, Int64)).new(4) }
r.times do |y|
  ais = read_line.split.map(&.to_i64)
  ais.each_with_index do |a, x|
    pres[y * c + x] << {y * c + x + 1, a}
    pres[y * c + x + 1] << {y * c + x, a}
  end
end
(r - 1).times do |y|
  bs = read_line.split.map(&.to_i64)
  bs.each_with_index do |b, x|
    pres[y * c + x] << {(y + 1) * c + x, b}
  end
end
r.times do |y|
  c.times do |x|
    pres[y * c + x] << {r * c + y * c + x, 1_i64}
    pres[r * c + y * c + x] << {y * c + x, 0_i64}
    if y != 0
      pres[r * c + y * c + x] << {r * c + (y - 1) * c + x, 1_i64}
    end
  end
end

INF = 1_000_000_000_000_000_000_i64

class Dijkstra
  property dist : Array(Int64)
  property pres : Array(Array(Tuple(Int64, Int64)))
  property n : Int64

  def initialize(@pres, @n)
    @dist = Array(Int64).new(@n, INF)
    @cnt = 0_i64
  end

  def dijkstra(s)
    @dist[s] = 0_i64

    queue = AtCoder::PriorityQueue(Tuple(Int64, Int64)).new {|(d, v)| -d}
    queue << {0_i64, s}

    until queue.empty?
      @cnt += 1
      d, v = queue.pop.not_nil!
      if @dist[v] < d
        next
      end

      @pres[v].each do |(to, cost)|
        if @dist[to] > @dist[v] + cost
          @dist[to] = @dist[v] + cost
          queue << {@dist[to], to}
        end
      end
    end
  end
end

dijkstra = Dijkstra.new(pres, r * c * 2)
dijkstra.dijkstra(0_i64)
p dijkstra.dist[r * c - 1]
