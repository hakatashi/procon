x, y = read_line.split.map(&.to_i64)
if x * 2 <= y && y <= x * 4 && y.even?
  puts "Yes"
else
  puts "No"
end
