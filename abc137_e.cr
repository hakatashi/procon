n, m, p = read_line.split.map(&.to_i64)
edges = Array(NamedTuple(a: Int64, b: Int64, c: Int64)).new
froms = Hash(Int64, Array(NamedTuple(b: Int64, c: Int64))).new
tos = Hash(Int64, Array(NamedTuple(a: Int64, c: Int64))).new
n.times do |i|
  froms[i] = [] of NamedTuple(b: Int64, c: Int64)
  tos[i] = [] of NamedTuple(a: Int64, c: Int64)
end
STDIN.gets_to_end.lines.each do |line|
  a, b, c = line.split.map(&.to_i64)
  edges << {a: a - 1, b: b - 1, c: p - c}
  tos[b - 1] << {a: a - 1, c: p - c}
end
real_edges = Array(NamedTuple(a: Int64, b: Int64, c: Int64)).new
def search(node : Int64, tos : Hash(Int64, Array(NamedTuple(a: Int64, c: Int64))), visited : Set(Int64))
  visited << node
  edges = Array(NamedTuple(a: Int64, b: Int64, c: Int64)).new
  tos[node].each do |to|
    edges << {a: to[:a], b: node, c: to[:c]}
    next if visited.includes? to[:a]
    edges += search(to[:a], tos, visited)
  end
  edges
end
visited = Set(Int64).new
real_edges = search(n - 1, tos, visited)
real_edges.each do |edge|
  froms[edge[:a]] << {b: edge[:b], c: edge[:c]}
end
def search2(node : Int64, froms : Hash(Int64, Array(NamedTuple(b: Int64, c: Int64))), visited : Set(Int64))
  visited << node
  edges = Array(NamedTuple(a: Int64, b: Int64, c: Int64)).new
  froms[node].each do |from|
    edges << {a: node, b: from[:b], c: from[:c]}
    next if visited.includes? from[:b]
    edges += search2(from[:b], froms, visited)
  end
  edges
end
visited2 = Set(Int64).new
real_edges_2 = search2(0_i64, froms, visited2)
d = Array(Int64).new(n, 10000000000_i64)
d[0] = 0_i64
n.times do |i|
  real_edges_2.each do |edge|
    if d[edge[:b]] > d[edge[:a]] + edge[:c]
      d[edge[:b]] = d[edge[:a]] + edge[:c]
      if i == n - 1
        puts -1
        exit
      end
    end
  end
end
puts [-d[n - 1], 0].max

