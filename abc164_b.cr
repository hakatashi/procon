a, b, c, d = read_line.split.map(&.to_i64)
loop do
  c -= b
  if c <= 0
    puts "Yes"
    exit
  end
  a -= d
  if a <= 0
    puts "No"
    exit
  end
end
