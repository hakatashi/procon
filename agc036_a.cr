s = read_line.to_u64
a = 1000000000_u64
d = (s.to_f / a.to_f).ceil.to_u64
b = 1_u64
c = d * a - s
puts "0 0 #{a} #{b} #{c} #{d}"
