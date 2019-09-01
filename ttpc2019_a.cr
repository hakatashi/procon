a, b, t = read_line.split.map(&.to_i)
tmp = b
loop do
  tmp += b - a
  if tmp >= t
    puts tmp
    exit
  end
end