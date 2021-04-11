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


n, m, x, y = read_line.split.map(&.to_i64)
x -= 1
y -= 1
trains = Array(Tuple(Int64, Int64, Int64, Int64)).new
train_lists = Hash(Int64, Array(Int64)).new {|h, k| h[k] = [] of Int64}
m.times do |i|
  a, b, t, k = read_line.split.map(&.to_i64)
  trains << {a - 1, b - 1, t, k}
  train_lists[a - 1] << i
  train_lists[b - 1] << i
end

class Node
  property index : Int64
  property done : Bool
  property cost : Int64
  def initialize(@index, @done, @cost)
  end
end

nodes = [] of Node
n.times do |i|
  node = Node.new(i, false, -1_i64)
  nodes << node
end

queue = AtCoder::PriorityQueue(Node).new {|node| -node.cost}
nodes[x].cost = 0_i64
queue << nodes[x]
visited = Set(Int64).new

until queue.empty?
  node = queue.pop.not_nil!
  node.done = true
  visited << node.index
  train_lists[node.index].each do |train_index|
    a, b, t, k = trains[train_index]
    if a == node.index
      dest = b
    else
      dest = a
    end
    new_cost = ((node.cost - 1) // k + 1) * k + t
    if nodes[dest].cost == -1 || new_cost < nodes[dest].cost
      nodes[dest].cost = new_cost
      unless visited.includes?(dest)
        queue << nodes[dest]
      end
    end
  end
end

p nodes[y].cost
