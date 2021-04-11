n = read_line.to_i64
ais = read_line.split.map(&.to_i64)
a_counts = Hash(Int64, Int64).new(0_i64)

ais.each do |a|
  a_counts[a] += 1
end

ans = 0_i64
a_counts.each do |a1, count1|
  a_counts.each do |a2, count2|
    ans += count1 * count2 * (a1 - a2) ** 2
  end
end
p ans // 2
