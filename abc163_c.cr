gets
ais = read_line.split.map(&.to_i64)
ans = Array(Int64).new(ais.size + 1, 0_i64)
ais.each do |a|
  ans[a - 1] += 1
end
ans.each do |a|
  p a
end