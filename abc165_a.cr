k = read_line.to_i64
a, b = read_line.split.map(&.to_i64)
a.upto(b) do |i|
  if i % k == 0
    puts "OK"
    exit
  end
end
puts "NG"
