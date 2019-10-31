n, m = read_line.split.map(&.to_i)
stores = [] of Tuple(Int64, Int64)
n.times do
  a, b = read_line.split.map(&.to_i64)
  stores << {a, b}
end
stores.sort!
counter = 0
ret = 0_i64
stores.each do |(a, b)|
  count = [[m - counter, 0].max, b].min
  ret += a * count
  counter += count
end
p ret
