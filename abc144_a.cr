a, b = read_line.split.map(&.to_i)
if a <= 9 && b <= 9
  puts a * b
else
  puts -1
end