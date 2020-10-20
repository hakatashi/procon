k = read_line.to_i64
s = read_line
if s.size <= k
  puts s
else
  puts s[0...k] + "..."
end
