n, m = read_line.split.map(&.to_i64)
pres = Array(Array(Int64)).new(n) { [] of Int64 }
m.times do
  a, b = read_line.split.map(&.to_i64)
  pres[a - 1] << b - 1
  pres[b - 1] << a - 1
end

queue = Deque(Int64).new
queue << 0_i64
visited = Set(Int64).new
visited << 0_i64
ans = Array(Int64).new(n, 0_i64)
until queue.empty?
  i = queue.shift
  pres[i].each do |child|
    next if visited.includes?(child)
    ans[child] = i
    queue << child
    visited << child
  end
end
puts "Yes"
1_u64.upto(n - 1) do |i|
  p ans[i] + 1
end
