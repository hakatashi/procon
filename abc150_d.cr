n, m = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)
lcm1 = ais.map {|a| a // 2}.reduce(1_i64) do |a, b|
  ret = a.lcm(b)
  if ret > m
    p 0
    exit
  end
  ret
end
if ais.any? {|a| (lcm1 // (a // 2)) % 2 == 0}
  p 0
  exit
end
lcm2 = ais.reduce(1_i64) do |a, b|
  ret = a.lcm(b)
  if ret > m
    p 1
    exit
  end
  ret
end
if m < lcm1
  p 0
else
  p (m - lcm1) // lcm2 + 1
end