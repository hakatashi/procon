n, m = read_line.split(" ").map(&.to_i)
edges = Array(NamedTuple(u: Int32, v: Int32)).new
precedings = Hash(Int32, Array(Int32)).new
n.times do |i|
  precedings[i + 1] = Array(Int32).new
end
m.times do
  u, v = read_line.split(" ").map(&.to_i)
  edges << {u: u, v: v}
  precedings[u] << v
end
s, t = read_line.split(" ").map(&.to_i)
visited = Hash(Int32, Int32).new
queue = [s]
visited[s] = 0
while queue.size > 0
  n = queue.shift
  reachables = [n]
  3.times do
    seen = Set(Int32).new
    reachables.each do |n|
      precedings[n].each do |n2|
        next if seen.includes? n2
        seen << n2
      end
    end
    reachables = seen.to_a
  end
  reachables.each do |n2|
    if n2 == t
      puts visited[n] + 1
      exit
    end
    unless visited.has_key? n2
      queue << n2
      visited[n2] = visited[n] + 1
    end
  end
end
puts -1

