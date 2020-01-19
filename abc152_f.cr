n = read_line.to_i64
pres = Array(Array(Tuple(Int64, Int64))).new(n) { [] of Tuple(Int64, Int64) }
(n - 1).times do |i|
  a, b = read_line.split.map(&.to_i64)
  pres[a - 1] << {b - 1, i.to_i64}
  pres[b - 1] << {a - 1, i.to_i64}
end
m = read_line.to_i64
consts = [] of Tuple(Int64, Int64)
m.times do
  u, v = read_line.split.map(&.to_i64)
  consts << {u - 1, v - 1}
end

edges = Array(Int64).new(n - 1) { 0_i64 }

def dfs(node, parent, parents, pres)
  pres[node].each do |(child, edge_i)|
    next if child == parent
    parents[child] = {node, edge_i}
    dfs(child, node, parents, pres)
  end
end

consts.each_with_index do |(u, v), i|
  parents = Array(Tuple(Int64, Int64)).new(n, {-1_i64, -1_i64})
  dfs(u, -1, parents, pres)
  node = v
  until node == u
    node, edge = parents[node]
    edges[edge] = edges[edge] | (1_i64 << i)
  end
end

ans = 0_i64

0_i64.upto((1_i64 << m) - 1) do |statuses|
  cnt = 0_i64
  edges.each do |edge_consts|
    if (edge_consts & statuses) != 0
      cnt += 1
    end
  end
  ans += (1_i64 << (n - 1 - cnt)) * ((-1_i64) ** statuses.popcount)
end
p ans
