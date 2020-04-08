# -*- contest: language-test-202001 -*-
# -*- status: skip -*-

n, y = read_line.split.map(&.to_i64)
0.upto(n) do |a|
  money = y - a * 10000
  count = n - a
  b = (money - 1000 * count) / 4000
  c = count - b
  if b >= 0 && c >= 0 && b % 1 == 0
    puts [a, b.to_i, c.to_i].join(" ")
    exit
  end
end
puts "-1 -1 -1"
