n = read_line.to_i64
seq = 0_i64
n.times do
  d1, d2 = read_line.split.map(&.to_i64)
  if d1 == d2
    seq += 1
    if seq == 3
      puts "Yes"
      exit
    end
  else
    seq = 0
  end
end
puts "No"
