t = read_line.to_i64
t.times do
  n = read_line.to_i64
  z = 0_i64
  until n.odd?
    n //= 2
    z += 1
  end
  if z > 1
    puts "Even"
  elsif z == 1
    puts "Same"
  else
    puts "Odd"
  end
end