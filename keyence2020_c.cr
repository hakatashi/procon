# -*- status: skip -*-

n, k, s = read_line.split.map(&.to_i64)
ret = [] of Int64
k.times do
  ret << s
end
(n - k).times do
  if s == 1_000_000_000
    ret << 1_i64
  else
    ret << s + 1
  end
end
puts ret.map(&.to_s).join(" ")
