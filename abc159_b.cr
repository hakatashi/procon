s = read_line
t = s[0..((s.size - 1) // 2) - 1]
u = s[((s.size + 3) // 2 - 1)..(s.size - 1)]
if s.reverse == s && t.reverse == t && u.reverse == u
  puts "Yes"
else
  puts "No"
end