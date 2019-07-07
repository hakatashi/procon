n, d = read_line.split.map(&.to_i64)
points = STDIN.gets_to_end.lines.map do |l|
  l.split.map(&.to_i)
end
r = points.combinations(2).count do |c|
  a, b = c
  Math.sqrt(a.zip(b).map {|av, bv| (av - bv) ** 2 } .sum) % 1 == 0
end
p r
