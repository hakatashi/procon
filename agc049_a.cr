# -*- mode: float -*-

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
  class SCC
    alias Adjacency = NamedTuple(in: Array(Int64), out: Array(Int64))

    getter size : Int64
    getter adjacencies : Array(Adjacency)

    def initialize(@size)
      @adjacencies = Array(Adjacency).new(@size) { {in: [] of Int64, out: [] of Int64} }

      @topological_order = Array(Int64).new(@size)
      @visit_counts = Array(Int64).new(@size, 0_i64)
      @visited = Set(Int64).new
      @stack = Deque(Int64).new
      @groups = Array(Set(Int64)).new
    end

    def add_edge(from, to)
      @adjacencies[from][:out] << to.to_i64
      @adjacencies[to][:in] << from.to_i64
    end

    def dfs(start)
      @stack << start
      @visited << start

      until @stack.empty?
        node = @stack.last
        children = @adjacencies[node][:out]

        if @visit_counts[node] < children.size
          child = children[@visit_counts[node]]
          @visit_counts[node] += 1

          unless @visited.includes?(child)
            @visited << child
            @stack << child
          end
        else
          @topological_order << node
          @stack.pop
        end
      end
    end

    def reverse_dfs(start)
      @stack << start
      @visited << start
      group = Set{start}

      until @stack.empty?
        node = @stack.pop
        children = @adjacencies[node][:in]

        children.each do |child|
          unless @visited.includes?(child)
            @stack << child
            @visited << child
            group << child
          end
        end
      end

      @groups << group
    end

    def scc
      @visited = Set(Int64).new
      @stack = Deque(Int64).new
      @visit_counts = Array(Int64).new(@size, 0_i64)
      @topological_order = Array(Int64).new(@size)
      @groups = Array(Set(Int64)).new

      @size.times do |node|
        unless @visited.includes?(node)
          dfs(node)
        end
      end

      @visited = Set(Int64).new

      @topological_order.reverse_each do |node|
        unless @visited.includes?(node)
          reverse_dfs(node)
        end
      end

      @groups
    end
  end
end


n = read_line.to_i64
scc = AtCoder::SCC.new(n)
edges = [] of Tuple(Int64, Int64)
n.times do |i|
  s = read_line
  s.chars.each_with_index do |c, j|
    if c == '1'
      scc.add_edge(i, j)
      edges << {i.to_i64, j.to_i64}
    end
  end
end
groups = scc.scc

node_to_group = Hash(Int64, Int64).new
groups.each_with_index do |group, i|
  group.each do |node|
    node_to_group[node] = i.to_i64
  end
end

parents = Array(Set(Int64)).new(groups.size) { Set(Int64).new }
edges.each do |(i, j)|
  if node_to_group[i] != node_to_group[j]
    parents[node_to_group[j]] << node_to_group[i]
  end
end

ans = 0.0_f64
groups.each_with_index do |nodes, group|
  queue = Deque(Int64).new
  queue << group.to_i64
  visited = Set(Int64).new
  visited << group.to_i64
  until queue.empty?
    group_id = queue.shift
    parents[group_id].each do |parent|
      next if visited.includes?(parent)
      queue << parent
      visited << parent
    end
  end
  sum = 0_i64
  visited.each do |group_id|
    sum += groups[group_id].size.to_i64
  end
  ans += nodes.size / sum
end
p ans
