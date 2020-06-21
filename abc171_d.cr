n = read_line.to_i64
ais = read_line.split.map(&.to_i64)
counts = Array(Int64).new(1_000_001_i64, 0_i64)
sum = ais.sum
ais.each do |a|
  counts[a] += 1
end

q = read_line.to_i64
q.times do
  b, c = read_line.split.map(&.to_i64)
  sum += counts[b] * (c - b)
  counts[c] += counts[b]
  counts[b] = 0
  p sum
end