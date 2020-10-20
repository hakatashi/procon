a, b = read_line.split.map(&.to_i64)
if a <= b
  puts a.to_s * b
else
  puts b.to_s * a
end
