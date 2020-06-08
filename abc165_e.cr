# -*- status: skip -*-
n, m = read_line.split.map(&.to_i64)
x = (m + 1) // 2
y = x * 2 + m // 2
m.times do |i|
  if i % 2 == 0
    puts "#{x - i // 2} #{x + 1 + i // 2}"
  else
    puts "#{y - i // 2} #{y + 2 + i // 2}"
  end
end