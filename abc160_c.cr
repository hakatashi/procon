k, n = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)
ans = k - ais.last + ais.first
ais.each_cons(2) do |(a, b)|
  if ans < (a - b).abs
    ans = (a - b).abs
  end
end
p k - ans