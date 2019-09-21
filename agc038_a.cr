# -*- status: skip -*-

h, w, a, b = read_line.split.map(&.to_u64)
h.times do |y|
  w.times do |x|
    print ((x < a) ^ (y < b)) ? "1" : "0"
  end
  puts
end