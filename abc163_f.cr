n = read_line.to_i64
cs = read_line.split.map(&.to_i64)
pres = Array(Array(Int64)).new(n) { [] of Int64 }
(n - 1).times do |i|
  a, b = read_line.split.map(&.to_i64)
  pres[a - 1] << b - 1
  pres[b - 1] << a - 1
end

class Dfs
  def initialize(@pres, @cs)
    n = @cs.size
    @ans = Array(Int64).new(n, n * (n + 1) / 2)
    @segments = Array(Int64).new(n, n)
  end

  def dfs(node, parent, segments)
    cnt = 1_i64
    @pres[node].each do |child|
      next if child == parent
      ncnt, _ = dfs(child, node)
      cnt += ncnt
    end
    hidden[@cs[node]]
    {cnt, cnt}
  end
end

dfs = Dfs.new(pres, cs)
dfs.dfs(0_i64, -1_i64, segments)
