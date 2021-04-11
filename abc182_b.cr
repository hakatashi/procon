gets
ais = read_line.split.map(&.to_i64)
ans = (2_i64..1000_i64).max_by do |i|
  ais.count {|a| a % i == 0}
end
p ans
