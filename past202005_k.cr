# -*- contest: past202005-open -*-

n, q = read_line.split.map(&.to_i64)
tops = Array(Int64).new(n) { |i| i.to_i64 }
parents = Array(Int64).new(n) { |i| i.to_i64 + n }

q.times do
  f, t, x = read_line.split.map(&.to_i64)
  tmp = tops[t - 1]
  tops[t - 1] = tops[f - 1]
  tops[f - 1] = parents[x - 1]
  parents[x - 1] = tmp
end

positions = Array(Int64).new(n, 0_i64)
n.times do |i|
  x = tops[i]
  until x >= n
    positions[x] = i
    x = parents[x]
  end
end
positions.each do |position|
  p position + 1
end
