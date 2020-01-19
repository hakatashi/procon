gets
ps = read_line.split.map(&.to_i64)
min = 1_000_000_i64
ans = 0_i64
ps.each_with_index do |pv, i|
  if min > pv
    ans += 1
    min = pv
  end
end
p ans