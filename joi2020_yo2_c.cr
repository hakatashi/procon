# -*- contest: joi2020yo2 -*-

d = Hash(Int32, Int32).new 1
i = read_line.to_i
i.times { |i| d[i + i.to_s.chars.map(&.to_i).sum] += d[i] }
p d[i]
