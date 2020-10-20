gets
ais = read_line.split.map(&.to_i64)
right = Array(Int64).new(ais.size, 0_i64)
left = Array(Int64).new(ais.size, 0_i64)
ais.each_with_index do |a, i|
  if i + a < ais.size
    right[i + a] += 1
  end
  if i - a >= 0
    left[i - a] += 1
  end
end
p left.zip(right).sum { |(l, r)| l * r }
