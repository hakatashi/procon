h, w = read_line.split.map(&.to_i64)
cells = Array(Array(Char)).new
start = {-1, -1}
h.times do |y|
  cells << read_line.chars
  pos = cells.last.index('.')
  if start == {-1, -1} && !pos.nil?
    start = {pos, y.to_i32}
  end
end

def ok(h, w, cells, visited, x, y)
  x >= 0 && y >= 0 && x < w && y < h && !visited.includes?({x, y}) && cells[y][x] == '.'
end

ans = 0_i64

h.times do |y|
  w.times do |x|
    next if cells[y][x] != '.'

    queue = Deque(Tuple(Int64, Int64, Int64)).new
    queue << {x, y, 0_i64}
    visited = Set(Tuple(Int64, Int64)).new
    visited << {x, y}
    last_depth = 0

    until queue.empty?
      x, y, depth = queue.shift
      last_depth = depth
      if ok(h, w, cells, visited, x - 1, y)
        queue << {x - 1, y, depth + 1}
        visited << {x - 1, y}
      end
      if ok(h, w, cells, visited, x + 1, y)
        queue << {x + 1, y, depth + 1}
        visited << {x + 1, y}
      end
      if ok(h, w, cells, visited, x, y - 1)
        queue << {x, y - 1, depth + 1}
        visited << {x, y - 1}
      end
      if ok(h, w, cells, visited, x, y + 1)
        queue << {x, y + 1, depth + 1}
        visited << {x, y + 1}
      end
    end

    if ans < last_depth
      ans = last_depth
    end
  end
end

p ans
