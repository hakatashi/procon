n = read_line.to_i64
edges = [] of Tuple(Int64, Int64)
(n - 1).times do
  a, b = read_line.split.map(&.to_i64)
  edges << {a, b}
end
left_weights = Array(Int64).new(n - 1, 0_i64)
right_weights = Array(Int64).new(n - 1, 0_i64)
q = read_line.to_i64
q.times do
  t, e, x = read_line.split.map(&.to_i64)
  if t == 1
    left_weights[e - 1] += x
  else
    right_weights[e - 1] += x
  end
end

pres = Array(Array(Tuple(Int64, Int64))).new(n) { [] of Tuple(Int64, Int64) }
edges.each_with_index do |(a, b), i|
  pres[a - 1] << {b - 1, left_weights[i]}
  pres[b - 1] << {a - 1, right_weights[i]}
end

class Solver
  property pres : Array(Array(Tuple(Int64, Int64)))
  property dp : Array(Int64)
  property ans : Array(Int64)

  def initialize(@pres)
    @dp = Array(Int64).new(@pres.size, 0_i64)
    @ans = Array(Int64).new(@pres.size, 0_i64)
  end

  def dfs1(node, parent)
    @pres[node].each do |(child, weight)|
      next if child == parent
      @dp[node] += dfs1(child, node) + weight
    end
    @dp[node]
  end

  def dfs2(node, parent, parent_dp)
    @pres[node].each do |(child, weight)|
      if child == parent
        @ans[node] += parent_dp + weight
      else
        @ans[node] += @dp[child] + weight
      end
    end
    @pres[node].each do |(child, weight)|
      next if child == parent
      dfs2(child, node, @ans[node] - (@dp[child] + weight))
    end
  end

  def solve
    dfs1(0_i64, -1_i64)
    dfs2(0_i64, -1_i64, 0_i64)
    @ans.each do |a|
      p a
    end
  end
end

solver = Solver.new(pres)
solver.solve

