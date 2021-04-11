n, m = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)
bs = read_line.split.map(&.to_i64)

def min(a, b)
  a > b ? b : a
end

class Dfs
  property ais : Array(Int64)
  property bs : Array(Int64)
  property dp : Hash(Tuple(Int64, Int64), Int64)

  def initialize(@ais, @bs)
    @dp = Hash(Tuple(Int64, Int64), Int64).new(1_000_000_000_i64)
  end

  def dfs(n, m)
    if @dp.has_key?({n, m})
      return @dp[{n, m}]
    end

    if n == 0
      return m
    end

    if m == 0
      return n
    end

    ret = min(dfs(n, m - 1) + 1, dfs(n - 1, m) + 1)
    if @ais[n - 1] == @bs[m - 1]
      ret = min(dfs(n - 1, m - 1), ret)
    else
      ret = min(dfs(n - 1, m - 1) + 1, ret)
    end

    @dp[{n, m}] = ret
  end
end

dfs = Dfs.new(ais, bs)
p dfs.dfs(n, m)
