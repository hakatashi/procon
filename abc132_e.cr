n, m = read_line.split.map(&.to_i64)
nodes = [] of Tuple(Int64, Int64)
pres = Array(Array(Int64)).new(n) { [] of Int64 }
m.times do
  u, v = read_line.split.map(&.to_i64)
  nodes << {u - 1, v - 1}
  pres[u - 1] << v - 1
end
s, t = read_line.split.map(&.to_i64)

queue = Deque(Tuple(Int64, Int64, Int64)).new
visited = Set(Tuple(Int64, Int64)).new
queue << {s - 1, 0_i64, 0_i64}
visited << {s - 1, 0_i64}
until queue.empty?
  node, mod, depth = queue.shift
  pres[node].each do |child|
    new_mod = (mod + 1) % 3
    if new_mod == 0 && child == t - 1
      p (depth + 1) // 3
      exit
    end
    next if visited.includes?({child, new_mod})
    visited << {child, new_mod}
    queue << {child, new_mod, depth + 1}
  end
end
p -1
