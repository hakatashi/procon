a, b, m = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)
bs = read_line.split.map(&.to_i64)
tickets = [] of Tuple(Int64, Int64, Int64)
m.times do
  x, y, c = read_line.split.map(&.to_i64)
  tickets << {x - 1, y - 1, c}
end
ans = ais.min + bs.min
tickets.each do |(x, y, c)|
  tmp = ais[x] + bs[y] - c
  if tmp < ans
    ans = tmp
  end
end
p ans
