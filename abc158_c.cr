a, b = read_line.split.map(&.to_i64)
ans = (1..100000).find do |i|
  i * 8 // 100 == a && i * 10 // 100 == b
end
p ans.nil? ? -1 : ans
