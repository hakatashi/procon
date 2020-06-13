a, v = read_line.split.map(&.to_i64)
b, w = read_line.split.map(&.to_i64)
t = read_line.to_i64

if v > w && (a - b).abs <= t * (v - w) 
  puts "YES"
else
  puts "NO"
end
