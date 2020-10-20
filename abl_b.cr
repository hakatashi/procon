a, b, c, d = read_line.split.map(&.to_i64)
if (a <= c && c <= b) || (a <= d && d <= b) || (c <= a && a <= d) || (c <= b && b <= d)
  puts "Yes"
else
  puts "No"
end
