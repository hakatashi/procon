s = read_line
ret = s.chars.each_with_index.any? do |c, i|
  if i % 2 == 0
    c == 'L'
  else
    c == 'R'
  end
end
if ret
  puts "No"
else
  puts "Yes"
end