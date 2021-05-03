# -*- status: skip -*-

h, w = read_line.split.map(&.to_i64)
cells = [] of Array(Int64)
h.times do
  ais = read_line.split.map(&.to_i64)
  cells << ais
end

operations = [] of Tuple(Int64, Int64, Int64, Int64)
(h - 1).times do |y|
  w.times do |x|
    if cells[y][x].odd?
      operations << {y, x, y + 1, x}
      cells[y + 1][x] += 1
    end
  end
end
w.times do |x|
  y = h - 1
  if x < w - 1 && cells[y][x].odd?
    operations << {y, x, y, x + 1}
    cells[y][x + 1] += 1
  end
end

p operations.size
operations.each do |(y, x, y2, x2)|
  puts "#{y + 1} #{x + 1} #{y2 + 1} #{x2 + 1}"
end
