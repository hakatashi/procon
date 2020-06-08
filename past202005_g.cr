# -*- contest: past202005-open -*-

n, dx, dy = read_line.split.map(&.to_i64)
cells = Array(Array(Int64)).new(600) { Array.new(600, 0_i64) }
n.times do
  bx, by = read_line.split.map(&.to_i64)
  cells[by + 300][bx + 300] = -1_i64
end

queue = Deque(Tuple(Int64, Int64, Int64)).new
visited = Set(Tuple(Int64, Int64)).new
queue << {300_i64, 300_i64, 0_i64}
until queue.empty?
  x, y, depth = queue.shift
  next if x < 0 || x >= 600
  next if y < 0 || y >= 600
  next if visited.includes?({x, y})
  next if cells[y][x] == -1
  if x == dx + 300 && y == dy + 300
    p depth
    exit
  end
  visited << {x, y}

  queue << {x + 1, y + 1, depth + 1}
  queue << {x, y + 1, depth + 1}
  queue << {x - 1, y + 1, depth + 1}
  queue << {x + 1, y, depth + 1}
  queue << {x - 1, y, depth + 1}
  queue << {x, y - 1, depth + 1}
end
p -1
