# -*- status: skip -*-

n, m = read_line.split.map(&.to_i)
sss = Array(Array(Char)).new
enemies = [] of Tuple(Int32, Int32)
pawns = [] of Tuple(Int32, Int32)
n.times do |y|
  ss = read_line.chars
  ss.each_with_index do |c, x|
    if c == 'Q'
      enemies << {x, y}
    end
    if c == 'X'

    end
  end
  sss << ss
end
enemies.each do |(x, y)|
  [
    [1, -1],
    [0, -1],
    [-1, -1],
    [-1, 0],
    [-1, 1],
    [0, 1],
    [1, 1],
    [1, 0],
  ].each do |(dx, dy)|
    if 0 <= x + dx && x + dx < n && 0 <= y + dy && y + dy < n
      sss[y + dy][x + dx] = '#'
    end
  end
end
sss.each do |ss|
  puts ss.join
end
