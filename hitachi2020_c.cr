n = read_line.to_i64
edges = [] of Tuple(Int64, Int64)
(n - 1).times do
  a, b = read_line.split.map(&.to_i64)
  edges << {a - 1, b - 1}
end
pres = Array(Array(Int64)).new(n) { [] of Int64 }
edges.each do |(a, b)|
  pres[a] << b
  pres[b] << a
end

def dfs1(node, parent, pres, counts, depth)
  counts[depth % 2] += 1
  pres[node].each do |child|
    next if child == parent
    dfs1(child, node, pres, counts, depth + 1)
  end
end

counts = [0_i64, 0_i64]
dfs1(0, -1, pres, counts, 0_i64)

def dfs2(node, parent, pres, ans, depth, info, n, counts)
  if counts[depth % 2] <= n // 3
    ans[node] = info[0]
    info[0] += 3
  elsif counts[(depth + 1) % 2] <= n // 3
    if info[1] <= n
      ans[node] = info[1]
      info[1] += 3
    elsif info[2] <= n
      ans[node] = info[2]
      info[2] += 3
    else
      ans[node] = info[0]
      info[0] += 3
    end
  elsif depth % 2 == 0
    if info[1] <= n
      ans[node] = info[1]
      info[1] += 3
    else
      ans[node] = info[0]
      info[0] += 3
    end
  else
    if info[2] <= n
      ans[node] = info[2]
      info[2] += 3
    else
      ans[node] = info[0]
      info[0] += 3
    end
  end
  pres[node].each do |child|
    next if child == parent
    dfs2(child, node, pres, ans, depth + 1, info, n, counts)
  end
end

ans = Array(Int64).new(n, 0_i64)
info = [3_i64, 1_i64, 2_i64]
dfs2(0, -1, pres, ans, 0_i64, info, n, counts)

puts ans.join(" ")
