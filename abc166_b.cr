n, k = read_line.split.map(&.to_i64)
s = Set(Int64).new
k.times do
  gets
  ais = read_line.split.map(&.to_i64)
  ais.each do |a|
    s << a
  end
end
p n - s.size
