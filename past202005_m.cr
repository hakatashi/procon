# -*- contest: past202005-open -*-

def min(a, b)
  a > b ? b : a
end

n, m = read_line.split.map(&.to_i64)
pres = Array(Array(Int64)).new(n) { [] of Int64 }
m.times do
  u, v = read_line.split.map(&.to_i64)
  pres[u - 1] << v - 1
  pres[v - 1] << u - 1
end
s = read_line.to_i64 - 1
k = read_line.to_i64
ts = read_line.split.map(&.to_i64).map { |town| town - 1 }

dists = Array(Array(Int64)).new(k + 1) { Array(Int64).new(k, 0_i64) }

([s] + ts).each_with_index do |start, i|
  queue = Deque(Tuple(Int64, Int64)).new
  visited = Set(Int64).new
  queue << {start, 0_i64}
  visited << start
  until queue.empty?
    town, depth = queue.shift
    target = ts.index(town)
    unless target.nil?
      dists[i][target] = depth
    end
    pres[town].each do |child|
      next if visited.includes?(child)
      queue << {child, depth + 1}
      visited << child
    end
  end
end

INF = 1_000_000_000_000_i64
dp = Array(Array(Int64)).new(k) { Array(Int64).new(2 ** k, INF) }
k.times do |i|
  dp[i][1 << i] = dists[0][i]
end
tour = (1...(2 ** k)).to_a.sort_by!(&.popcount)
tour.each do |state|
  k.times do |i|
    d = dp[i][state]
    next if d == INF
    k.times do |j|
      next if i == j
      next if state & (1 << j) != 0
      new_state = state | (1 << j)
      dp[j][new_state] = min(dp[j][new_state], d + dists[i + 1][j])
    end
  end
end
p dp.map(&.last).min
