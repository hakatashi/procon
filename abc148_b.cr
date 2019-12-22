gets
s, t = read_line.split
a = (1..s.size).map do |i|
  s[i - 1].to_s + t[i - 1].to_s
end.join
puts a