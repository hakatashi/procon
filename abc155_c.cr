n = read_line.to_i64
counts = Hash(String, Int64).new(0_i64)
n.times do
  counts[read_line] += 1
end
max_count = counts.values.max
outs = [] of String
counts.each do |(k, v)|
  if v == max_count
    outs << k
  end
end
outs.sort.each do |o|
  puts o
end
