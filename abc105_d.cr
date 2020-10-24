n, m = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)
h = Hash(Int64, Int64).new(0_i64)
sum = 0_i64
ans = 0_i64
ais.each do |a|
  h[sum] += 1
  sum = (sum + a) % m
  ans += h[sum]
end
p ans