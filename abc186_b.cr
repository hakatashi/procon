h, w = read_line.split.map(&.to_i64)
ais = [] of Int64
h.times do
  vs = read_line.split.map(&.to_i64)
  vs.each do |v|
    ais << v
  end
end
p ais.sum - ais.min * ais.size
