m, h = read_line.split.map(&.to_i64)
if h % m == 0
  puts "Yes"
else
  puts "No"
end