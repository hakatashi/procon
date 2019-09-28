n, m = read_line.split.map(&.to_u64)
ais = [] of UInt64
css = [] of Array(UInt64)
m.times do 
  a, b = read_line.split.map(&.to_u64)
  ais << a
  cs = read_line.split.map(&.to_u64)
  css << cs
end
dp = Array(Array(UInt64)).new(2) { Array(UInt64).new(2 ** n, UInt64::MAX / 2) }
dp[0][0] = 0_u64
dp[1][0] = 0_u64
ais.each_with_index do |a, i|
  old_dp = dp[i % 2]
  new_dp = dp[(i + 1) % 2]
  bitmask = 0
  css[i].each do |c|
    bitmask = bitmask | (1 << (c - 1))
  end
  old_dp.each_with_index do |d, i|
    new_dp[i] = d
  end
  old_dp.each_with_index do |d, i|
    new_dp[i | bitmask] = [d + a, new_dp[i | bitmask]].min
  end
end
if dp[ais.size % 2].last >= UInt64::MAX / 2
  puts "-1"
else
  puts dp[ais.size % 2].last
end