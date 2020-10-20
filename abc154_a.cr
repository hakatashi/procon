s, t = read_line.split
a, b = read_line.split.map(&.to_i64)
u = read_line
if s == u
  puts [a - 1, b].join(" ")
else
  puts [a, b - 1].join(" ")
end
