# -*- contest: language-test-202001 -*-

n = read_line.to_i64
ct, cx, cy = 0_i64, 0_i64, 0_i64
n.times do
  t, x, y = read_line.split.map(&.to_i64)
  dist = (cx - x).abs + (cy - y).abs
  if dist > t - ct || (dist + t - ct) % 2 != 0
    puts "No"
    exit
  end
  ct, cx, cy = t, x, y
end
puts "Yes"
