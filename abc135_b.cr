gets
ps = read_line.split.map(&.to_u64)
un = nil
ps.each_with_index do |a, i|
  if a != i + 1
    un = i
    break
  end
end
if un.nil?
  puts "YES"
else
  temp1 = ps[un]
  temp2 = ps[ps[un] - 1]
  ps[ps[un] - 1] = temp1
  ps[un] = temp2
  if ps.each_cons(2).all? { |con| con[0] < con[1] }
    puts "YES"
  else
    puts "NO"
  end
end
