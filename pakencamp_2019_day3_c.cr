n, m = read_line.split.map(&.to_i64)
ais = Array(Array(Int64)).new
n.times do |i|
  ais << read_line.split.map(&.to_i64)
end
ans = 0_i64
(0...m).to_a.each_combination(2) do |(t1, t2)|
  ret = (0...n).map { |i| ais[i][t1] > ais[i][t2] ? ais[i][t1] : ais[i][t2] }.sum
  ans = ret if ret > ans
end
p ans
