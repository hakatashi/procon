n, k = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)
ans = (1_i64..1_000_000_000_i64).bsearch do |i|
  cuts = ais.sum do |a|
    (a - 1) // i
  end
  cuts <= k
end
p ans
