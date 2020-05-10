n, m = read_line.split.map(&.to_i64)
hs = read_line.split.map(&.to_i64)
pres = Array(Array(Int64)).new(n) { [] of Int64 }
m.times do
  a, b = read_line.split.map(&.to_i64)
  pres[a - 1] << b - 1
  pres[b - 1] << a - 1
end
ans = pres.each.with_index.count do |nodes, i|
  nodes.all? {|node| hs[node] < hs[i]}
end
p ans
