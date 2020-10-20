n, u, v = read_line.split.map(&.to_i)
pres = Array(Array(Int32)).new(n) { [] of Int32 }
(n - 1).times do |i|
  a, b = read_line.split.map(&.to_i)
  pres[a - 1] << b - 1
  pres[b - 1] << a - 1
end
prevs = Array(Int32).new(n, -1)

def dfs(node, prev, pres, prevs, leaves)
  count = 0
  pres[node].each do |i|
    if i != prev
      prevs[i] = node
      dfs(i, node, pres, prevs, leaves)
      count += 1
    end
  end
  if count == 0
    leaves << node
  end
end

leaves = [] of Int32
dfs(v - 1, -1, pres, prevs, leaves)
path = Set(Int32).new
path << u - 1
prev = prevs[u - 1]
until prev == -1
  path << prev
  prev = prevs[prev]
end
ret = 0

def dfs2(node, prev, pres, len, path, depth, ret)
  count = 0
  if path.includes?(node)
    len += 1
  end
  pres[node].each do |i|
    if i != prev
      dfs2(i, node, pres, len, path, depth + 1, ret)
      count += 1
    end
  end
  if count == 0
    shared = len
    me = depth - shared
    you = path.size - 1 - len
    if shared > you
      ret << depth - 1
    end
  end
end

ret = [] of Int32
dfs2(v - 1, -1, pres, -1, path, 0, ret)
p ret.max
