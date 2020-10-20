n = read_line.to_i64
ais = read_line.split.map(&.to_i64)
pres = Array(Array(Int64)).new(n) { [] of Int64 }
(n - 1).times do
  u, v = read_line.split.map(&.to_i64)
  pres[u - 1] << v - 1
  pres[v - 1] << u - 1
end

class Dfs
  def initialize(@ais : Array(Int64), @pres : Array(Array(Int64)))
    @dp = Deque(Int64).new
    @dp << @ais[0]
    @ans = Array(Int64).new(@ais.size, 0_i64)
    dfs(0_i64, -1_i64)
    @ans.each do |a|
      p a
    end
  end

  def dfs(node, parent)
    @ans[node] = @dp.size.to_i64
    @pres[node].each do |child|
      next if child == parent
      a = @ais[child]
      i = @dp.bsearch_index { |d| d >= a }
      if i.nil?
        @dp << a
        dfs(child, node)
        @dp.pop
      else
        tmp = @dp[i]
        @dp[i] = a
        dfs(child, node)
        @dp[i] = tmp
      end
    end
  end
end

Dfs.new(ais, pres)
