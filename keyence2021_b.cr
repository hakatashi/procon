n, k = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)

counts = Hash(Int64, Int64).new {|h, k| h[k] = 0_i64 }
ais.each do |a|
  counts[a] += 1
end

width = k
ans = 0_i64
n.times do |i|
  count = counts[i]
  if count < width
    width = count
  end
  ans += width
end
p ans
