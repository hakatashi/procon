# -*- contest: past202005-open -*-

s = read_line
t = read_line

if s == t
  puts "same"
elsif s.downcase == t.downcase
  puts "case-insensitive"
else
  puts "different"
end