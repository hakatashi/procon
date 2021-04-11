r1, c1 = read_line.split.map(&.to_i64)
r2, c2 = read_line.split.map(&.to_i64)

dist = (r1 - r2).abs + (c1 - c2).abs
if dist == 0
  p 0
elsif dist <= 3
  p 1
elsif (r1 - r2).abs == (c1 - c2).abs
  p 1
elsif dist <= 6
  p 2
elsif (r1 + c1 - r2 - c2) % 2 == 0
  p 2
elsif ((r1 - r2).abs - (c1 - c2).abs).abs <= 3
  p 2
else
  p 3
end
