# -*- status: skip -*-

n, m = read_line.split.map(&.to_i64)
bombs = [] of Tuple(Int64, Int64)
codes = [] of Tuple(Int64, Int64)
code_ends = [] of Tuple(Int64, Int64, Bool)

n.times do
  a, b = read_line.split.map(&.to_i64)
  bombs << {a, b}
end
m.times do |i|
  l, r = read_line.split.map(&.to_i64)
  codes << {l, r}
  code_ends << {l, i.to_i64, true}
  code_ends << {r + 1, i.to_i64, false}
end

bombs.sort_by! { |(a, b)| a }

odds = Array(Bool).new(bombs.size + 1, false)
prev = false
parity = false
bombs.each_with_index do |(a, b), i|
  now = b == 1
  if prev != now
    odds[i] = true
    parity = !parity
  end
  prev = now
end
if parity
  odds[bombs.size] = true
end

edges = Array(Array(Int64)).new(codes.size) { [-1_i64, -1_i64] }
code_ends.sort_by! { |(x, i, type)| x }
bombs.each_with_index do |(a, b), i|
  until code_ends.empty? || code_ends[0][0] > a
    x, code_index, type = code_ends.shift
    if type == true
      edges[code_index][0] = i.to_i64
    else
      edges[code_index][1] = i.to_i64
    end
  end
end
code_ends.each do |(x, code_index, type)|
  if type == true
    edges[code_index][0] = bombs.size.to_i64
  else
    edges[code_index][1] = bombs.size.to_i64
  end
end

pres = Array(Array(Tuple(Int64, Int64))).new(bombs.size + 1) { [] of Tuple(Int64, Int64) }
edges.each_with_index do |(left, right), i|
  if left != right
    pres[left] << {right, i.to_i64}
    pres[right] << {left, i.to_i64}
  end
end
odd_set = Set(Int64).new
odds.each_with_index do |odd, i|
  if odd
    odd_set << i.to_i64
  end
end

if odd_set.size == 0
  p 0
  exit
end

visited = Set(Int64).new
visited << 0_i64
paint_edges = [] of Int64

childrens = Array(Array(Int64)).new(bombs.size + 1) { [] of Int64 }
parents = Hash(Int64, Tuple(Int64, Int64)).new
dp = Array(Bool).new(bombs.size + 1, false)

while odd_set.size > 0
  root = odd_set.first

  stack = [root]
  sorted_nodes = [] of Int64
  visited << root
  until stack.empty?
    node = stack.pop
    sorted_nodes << node
    pres[node].each do |(pre, edge_index)|
      next if pre == node
      next if visited.includes?(pre)
      visited << pre
      stack << pre
      childrens[node] << pre
      parents[pre] = {node, edge_index}
    end
  end
  sorted_nodes.reverse_each do |node|
    ret = false
    if odd_set.includes?(node)
      ret = true
      odd_set.delete(node)
    end
    childrens[node].each do |child|
      if dp[child]
        ret = !ret
      end
    end
    if ret
      if node == root
        p -1
        exit
      end
      parent, parent_edge = parents[node].not_nil!
      paint_edges << parent_edge + 1
    end
    dp[node] = ret
  end
end

p paint_edges.size
puts paint_edges.sort.join(" ")
