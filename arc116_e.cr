n, k = read_line.split.map(&.to_i64)
pres = Array(Array(Int64)).new(n) { [] of Int64 }
(n - 1).times do
  u, v = read_line.split.map(&.to_i64)
  pres[u - 1] << v - 1
  pres[v - 1] << u - 1
end

def max(a, b)
  a > b ? a : b
end

class Dfs
  def initialize(@i : Int64, @pres : Array(Array(Int64)))
  end

  def dfs(node, parent)
    debts = [0_i64]
    k = 0_i64
    @pres[node].each do |child|

      next if child == parent
      child_debt, child_k = dfs(child, node)
      debts << child_debt
      k += child_k
    end
    max_profit = -debts.min
    max_debt = debts.max

    if max_debt < max_profit
      return -max_profit + 1, k
    end

    if max_debt == 0 && max_profit == 0
      return -max_profit + 1, k
    end

    if max_debt == @i
      return -@i, k + 1
    end

    return max_debt + 1, k
  end
end

ans = (1_i64..n).bsearch do |i|
  dfs = Dfs.new(i, pres)
  debt, k_need = dfs.dfs(0_i64, -1_i64)
  if debt > 0
    k_need += 1
  end
  k_need <= k
end

p ans
