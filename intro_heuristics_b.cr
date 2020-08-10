d = read_line.to_i64
cs = read_line.split.map(&.to_i64)
sss = [] of Array(Int64)
d.times do
  sss << read_line.split.map(&.to_i64)
end
ans = 0_i64
last = cs.map { 0_i64 }
d.times do |i|
  t = read_line.to_i64
  ans += sss[i][t - 1]
  last[t - 1] = i + 1
  last.each_with_index do |l, j|
    ans -= cs[j] * (i - l + 1)
  end
  p ans
end