gets
ais = read_line.split.map(&.to_i64)
if ais.any? {|a| a == 0}
  p ais.sum(&.abs)
elsif ais.count {|a| a < 0} % 2 == 0
  p ais.sum(&.abs)
else
  p ais.sum(&.abs) - ais.min_by(&.abs).abs * 2
end
