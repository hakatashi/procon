def product_overflow?(a, b)
  a.to_s(2).size + b.to_s(2).size > 64
end

x, k, d = read_line.split.map(&.to_i64)
if x < 0
  x = -x
end

if !product_overflow?(d, k) && x > d * k
  p x - d * k
  exit
end

if k.odd?
  x2 = x - d
else
  x2 = x
end
c1 = x2 % (d * 2)
c2 = c1 - (d * 2)
p [c1.abs, c2.abs].min
