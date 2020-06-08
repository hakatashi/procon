n = read_line.to_i64
ais = Array(Int64).new(n)
bs = Array(Int64).new(n)
n.times do
  a, b = read_line.split.map(&.to_i64)
  ais << a
  bs << b
end

ais.sort!
bs.sort!

if n.odd?
  s = ais[n // 2]
  e = bs[n // 2]
  p e - s + 1
else
  s = ais[n // 2 - 1] + ais[n // 2]
  e = bs[n // 2 - 1] + bs[n // 2]
  p e - s + 1
end
