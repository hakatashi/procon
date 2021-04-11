n, x = read_line.split.map(&.to_i64)
alc100 = 0_i64
n.times do |i|
  v, p = read_line.split.map(&.to_i64)
  alc100 += v * p
  if alc100 > x * 100
    puts i + 1
    exit
  end
end
puts -1
