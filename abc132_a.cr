s = read_line
cs = s.chars
if cs.uniq.size != 2
  puts "No"
else
  a, b = cs.uniq
  if cs.select { |c| c == a }.size == 2 && cs.select { |c| c == b }.size == 2
    puts "Yes"
  else
    puts "No"
  end
end
