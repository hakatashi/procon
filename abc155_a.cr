a, b, c = read_line.split.map(&.to_i64)
if a == b && a != c
  puts "Yes"
elsif b == c && c != a
  puts "Yes"
elsif c == a && a != b
  puts "Yes"
else
  puts "No"
end

