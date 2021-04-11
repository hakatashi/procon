# ac-library.cr by hakatashi https://github.com/google/ac-library.cr
#
# Copyright 2021 Google LLC
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
  class MaxFlow
    class Edge
      getter to : Int64
      getter reverse_index : Int64
      property capacity : Int64

      def initialize(@to, @capacity, @reverse_index)
      end
    end

    # Number of nodes
    getter size : Int64

    # Adjacency list
    getter adjacencies : Array(Array(Edge))

    getter depths : Array(Int64)

    # Number of visited adjacencies for each nodes
    getter visit_counts : Array(Int64)

    def initialize(@size)
      @adjacencies = Array(Array(Edge)).new(@size) { [] of Edge }
      @depths = Array(Int64).new(@size, -1_i64)
      @visit_counts = Array(Int64).new(@size, 0_i64)
    end

    def add_edge(from, to, capacity)
      from_index = @adjacencies[from].size.to_i64
      to_index = @adjacencies[to].size.to_i64

      @adjacencies[from] << Edge.new(to.to_i64, capacity.to_i64, to_index)
      @adjacencies[to] << Edge.new(from.to_i64, 0_i64, from_index)
    end

    def flow(start, target)
      flow = 0_i64

      loop do
        bfs(start)
        if @depths[target] < 0
          return flow
        end

        @visit_counts.fill(0_i64)
        while (flowed = dfs(start, target, Int64::MAX)) > 0
          flow += flowed
        end
      end
    end

    private def bfs(start)
      @depths.fill(-1_i64)
      queue = Deque(Int64).new

      @depths[start] = 0_i64
      queue << start.to_i64
      until queue.empty?
        node = queue.shift

        @adjacencies[node].each do |edge|
          if edge.capacity > 0 && @depths[edge.to] < 0
            @depths[edge.to] = @depths[node] + 1
            queue << edge.to
          end
        end
      end
    end

    private def dfs(node, target, flow)
      return flow if node == target

      edges = @adjacencies[node]
      while @visit_counts[node] < edges.size
        edge = edges[@visit_counts[node]]
        if edge.capacity > 0 && @depths[node] < @depths[edge.to]
          flowed = dfs(edge.to, target, min(flow, edge.capacity))

          if flowed > 0
            edge.capacity -= flowed
            @adjacencies[edge.to][edge.reverse_index].capacity += flowed
            return flowed
          end
        end

        @visit_counts[node] += 1
      end

      0_i64
    end

    @[AlwaysInline]
    private def min(a, b)
      a > b ? b : a
    end
  end
end



def flip(cell)
  if cell == 'B'
    'W'
  else
    'B'
  end
end

n = read_line.to_i64
css = [] of Array(Char)
n.times do
  cs = read_line.chars
  css << cs
end

n.times do |y|
  n.times do |x|
    if ((y + x) % 2).odd? && css[y][x] != '?'
      css[y][x] = flip(css[y][x])
    end
  end
end

# 0: start
# 1..n*n: cell
# n*n+1..n*n+n*n*4: edge
# n*n+n*n*4+1: target
# B => 0
# W => 1
flow = AtCoder::MaxFlow.new(n * n * 4 + n * n + 2)
start_id = 0_i64
target_id = n * n * 5 + 1

max_score = 0_i64

INF = 100_000_000_000_000_000_i64

n.times do |y|
  n.times do |x|
    cell = css[y][x]

    cell_id = y * n + x + 1

    in_cap = 0_i64
    out_cap = 0_i64

    if x - 1 >= 0
      if cell == '?'
        edge_id = n * n + (y * n + x) * 4 + 1
        edge2_id = n * n + (y * n + x) * 4 + 2
        cell2_id = y * n + x
        case css[y][x - 1]
        when 'B'
          in_cap += 1
        when 'W'
          out_cap += 1
        when '?'
          flow.add_edge(edge_id, target_id, 1_i64)
          flow.add_edge(cell_id, edge_id, INF)
          flow.add_edge(cell2_id, edge_id, INF)

          flow.add_edge(start_id, edge2_id, 1_i64)
          flow.add_edge(edge2_id, cell_id, INF)
          flow.add_edge(edge2_id, cell2_id, INF)
        end
        max_score += 1
      elsif css[y][x - 1] == cell
        max_score += 1
      end
    end
    if x + 1 < n && cell == '?'
      case css[y][x + 1]
      when 'B'
        in_cap += 1
      when 'W'
        out_cap += 1
      end
      max_score += 1
    end
    if y - 1 >= 0
      if cell == '?'
        edge_id = n * n + (y * n + x) * 4 + 3
        edge2_id = n * n + (y * n + x) * 4 + 4
        cell2_id = (y - 1) * n + x + 1
        case css[y - 1][x]
        when 'B'
          in_cap += 1
        when 'W'
          out_cap += 1
        when '?'
          flow.add_edge(edge_id, target_id, 1_i64)
          flow.add_edge(cell_id, edge_id, INF)
          flow.add_edge(cell2_id, edge_id, INF)

          flow.add_edge(start_id, edge2_id, 1_i64)
          flow.add_edge(edge2_id, cell_id, INF)
          flow.add_edge(edge2_id, cell2_id, INF)
        end
        max_score += 1
      elsif css[y - 1][x] == cell
        max_score += 1
      end
    end
    if y + 1 < n && cell == '?'
      case css[y + 1][x]
      when 'B'
        in_cap += 1
      when 'W'
        out_cap += 1
      end
      max_score += 1
    end

    if cell == '?'
      flow.add_edge(0, cell_id, in_cap)
      flow.add_edge(cell_id, target_id, out_cap)
    end
  end
end

p max_score - flow.flow(start_id, target_id)
