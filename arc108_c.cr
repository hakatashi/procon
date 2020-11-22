n, m = read_line.split.map(&.to_i64)
pres = Array(Array(Tuple(Int64, Int64, Int64))).new(n) { [] of Tuple(Int64, Int64, Int64) }
m.times do |i|
  u, v, c = read_line.split.map(&.to_i64)
  pres[u - 1] << {v - 1, c - 1, i.to_i64}
  pres[v - 1] << {u - 1, c - 1, i.to_i64}
end

active_edges = Set(Int64).new
visited = Set(Int64).new
visited << 0_i64
queue = Deque(Int64).new
queue << 0_i64
until queue.empty?
  node = queue.shift
  pres[node].each do |(pre, c, i)|
    next if visited.includes?(pre)
    queue << pre
    visited << pre
    active_edges << i
  end
end

class Dfs
  property pres : Array(Array(Tuple(Int64, Int64, Int64)))
  property active_edges : Set(Int64)
  property n : Int64
  property ans : Array(Int64)

  def initialize(@pres, @active_edges, @n)
    @ans = Array(Int64).new(n, -1_i64)
  end

  def dfs(node, parent)
    pres[node].each do |(child, c, i)|
      next unless @active_edges.includes?(i)
      next if child === parent
      if @ans[node] != c
        @ans[child] = c
      else
        @ans[child] = c == 0 ? 1_i64 : 0_i64
      end
      dfs(child, node)
    end
  end
end

dfs = Dfs.new(pres, active_edges, n)
dfs.ans[0] = 0_i64
dfs.dfs(0_i64, -1_i64)

dfs.ans.each do |ans|
  p ans + 1
end