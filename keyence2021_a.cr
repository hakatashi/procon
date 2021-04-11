n = read_line.to_i64
ais = read_line.split.map(&.to_i64)
bs = read_line.split.map(&.to_i64)

max_a = 0_i64
max_b = 0_i64
true_max_a = 0_i64
n.times do |i|
  a = ais[i]
  b = bs[i]
  if a > true_max_a
    true_max_a = a
  end
  if b > max_b
    max_a = true_max_a
    max_b = b
  else
    if true_max_a * b > max_a * max_b
      max_a = true_max_a
      max_b = b
    end
  end
  p max_a * max_b
end
