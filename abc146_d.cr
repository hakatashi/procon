n = read_line.to_i
edges = [] of Tuple(Int32, Int32)
precedings = Array.new(n) { Set(Tuple(Int32, Int32)).new }
edge_colors = Array.new(n - 1) { 0 }
(n - 1).times do |i|
  a, b = read_line.split.map(&.to_i)
  edges << {a - 1, b - 1}
  precedings[a - 1] << {b - 1, i}
  precedings[b - 1] << {a - 1, i}
end
k = precedings.max_of(&.size)
def dfs(node, precedings, prev, prev_color, edges, k, edge_colors)
  color = 1
  color += 1 if color == prev_color
  precedings[node].each do |preceding, edge_index|
    next if preceding == prev
    edge_colors[edge_index] = color
    dfs(preceding, precedings, node, color, edges, k, edge_colors)
    color += 1
    color += 1 if color == prev_color
  end
end
dfs(0, precedings, 0, 0, edges, k, edge_colors)
p k
edge_colors.each do |color|
  p color
end
