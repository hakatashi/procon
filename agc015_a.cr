n, a, b = read_line.split(" ").map(&.to_u64)
if a > b
  puts 0
elsif a == b
  puts 1
elsif n == 1
  puts 0
else
  min = a + b + (n - 2) * a
  max = a + b + (n - 2) * b
  puts max - min + 1
end
