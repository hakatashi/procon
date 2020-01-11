a, b, k = read_line.split.map(&.to_i64)
if k <= a
  puts "#{a - k} #{b}"
elsif k <= a + b
  puts "0 #{b - (k - a)}"
else
  puts "0 0"
end