a, b = read_line.split.map(&.to_i64)
if (a - b) % 2 == 1
  puts "IMPOSSIBLE"
  exit
end
puts (a - b).abs / 2 + [a, b].min
