gets
ais = read_line.split.map(&.to_u64)
bs = read_line.split.map(&.to_u64)
new_ais = Array(UInt64).new(ais.size, 0_u64)
bs.each_with_index do |b, i|
  a = [(ais[i] - new_ais[i]), b].min
  new_ais[i] += a
  new_ais[i + 1] += [b - a, ais[i + 1]].min
end
p new_ais.sum
