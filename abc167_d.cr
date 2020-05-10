n, k = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64).map {|a| a - 1}
history = Array(Int64).new(n)
history << 0_i64
visited = Set(Int64).new
visited << 0_i64
until visited.includes?(ais[history.last])
  visited << ais[history.last]
  history << ais[history.last]
end
if k < history.size
  p history[k] + 1
  exit
end
leading = history.index(ais[history.last]).not_nil!.to_i64
loop_size = history.size.to_i64 - leading
p history[(k - leading) % loop_size + leading] + 1
