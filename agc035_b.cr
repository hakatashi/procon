# -*- status: skip -*-

n, m = read_line.split(" ").map(&.to_u64)
if m % 2 == 1
  puts "-1"
  exit
end
precedings = Hash(UInt64, Set(UInt64)).new
n.times do |i|
  precedings[i + 1] = Set(UInt64).new
end
edges = STDIN.gets_to_end.lines.each do |line|
  a, b = line.split(" ").map(&.to_u64)
  precedings[a] << b
  precedings[b] << a
end

def dfs(parent : UInt64, node : UInt64, visited : Set(UInt64), precedings : Hash(UInt64, Set(UInt64)))
  nodes = precedings[node]
  out = 0
  visited << node
  nodes.each do |n|
    if n == parent
      next
    end
    if visited.includes? n
      puts "#{node} #{n}"
      out += 1
      precedings[n].delete node
      next
    end
    is_out = dfs(node, n, visited, precedings)
    if is_out
      puts "#{node} #{n}"
      out += 1
    else
      puts "#{n} #{node}"
    end
  end
  out % 2 == 0
end

visited = Set(UInt64).new
data = dfs(0_u64, 1_u64, visited, precedings)
