n = read_line.to_i64
points = [] of Tuple(Int64, Int64)
n.times do
  x, y = read_line.split.map(&.to_i64)
  points << {x, y}
end
points.each_combination(3) do |(a, b, c)|
  ax, ay = a
  bx, by = b
  cx, cy = c
  dx1 = bx - ax
  dx2 = cx - ax
  dy1 = by - ay
  dy2 = cy - ay
  if dx2 * dy1 == dx1 * dy2
    puts "Yes"
    exit
  end
end
puts "No"