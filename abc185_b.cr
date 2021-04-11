def min(a, b)
  a > b ? b : a
end
n, m, t = read_line.split.map(&.to_i64)
ct = 0_i64
battery = n
m.times do
  a, b = read_line.split.map(&.to_i64)
  battery -= a - ct
  if battery <= 0
    puts "No"
    exit
  end
  battery += b - a
  battery = min(battery, n)
  ct = b
end
battery -= t - ct
if battery <= 0
  puts "No"
  exit
end
puts "Yes"