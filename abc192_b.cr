s = read_line
if s.chars.each.with_index.all? {|c, i| i.even? ? c.lowercase? : c.uppercase?}
  puts "Yes"
else
  puts "No"
end