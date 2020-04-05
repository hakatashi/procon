gets
s = read_line
if s.size % 2 == 0 && s[0...(s.size // 2)] == s[(s.size // 2)..-1]
  puts "Yes"
else
  puts "No"
end