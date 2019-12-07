# -*- contest: sumitrust2019 -*-

t1, t2 = read_line.split.map(&.to_i64)
a1, a2 = read_line.split.map(&.to_i64)
b1, b2 = read_line.split.map(&.to_i64)

if a1 * t1 + a2 * t2 == b1 * t1 + b2 * t2
  puts "infinity"
  exit
end

if a1 * t1 + a2 * t2 < b1 * t1 + b2 * t2
  a1, a2, b1, b2 = b1, b2, a1, a2
end

if a1 * t1 > b1 * t1
  p 0
  exit
end

ret = (b1 * t1 - a1 * t1) / ((a1 * t1 + a2 * t2) - (b1 * t1 + b2 * t2)) * 2 + 1
if (b1 * t1 - a1 * t1) % ((a1 * t1 + a2 * t2) - (b1 * t1 + b2 * t2)) == 0
  ret -= 1
end
p ret
