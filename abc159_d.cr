gets
ais = read_line.split.map(&.to_i64)
counts = Hash(Int64, Int64).new(0_i64)
ais.each do |a|
  counts[a] += 1
end
ans = 0_i64
counts.each do |v, c|
  ans += c * (c - 1) / 2
end
ais.each do |a|
  c = counts[a]
  p ans - c * (c - 1) / 2 + (c - 1) * (c - 2) / 2
end