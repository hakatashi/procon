# -*- status: skip -*-

n, m = read_line.split.map(&.to_i64)
if n == 1 && m == 0
  puts "1 2"
  exit
end
if m < 0 || m >= n - 1
  p -1
  exit
end
if m == 0
  n.times do |i|
    puts "#{i * 2 + 1} #{i * 2 + 2}"
  end
  exit
end
(n - m - 1).times do |i|
  puts "#{i + 1} #{n * 2 - i}"
end
(m + 1).times do |i|
  puts "#{i * 2 + n - m} #{i * 2 + n - m + 1}"
end