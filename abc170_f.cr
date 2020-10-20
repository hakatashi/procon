h, w, k = read_line.split.map(&.to_i64)
y1, x1, y2, x2 = read_line.split.map(&.to_i64)
css = [] of Array(Char)
h.times do
  css << read_line.chars
end
queue = Deque(Tuple(Int64, Int64, Int64)).new(h * w)
visited = Hash(Tuple(Int64, Int64), Int64).new(1_000_000_000_000_i64, h * w)
queue << {x1 - 1, y1 - 1, 0_i64}
visited[{x1 - 1, y1 - 1}] = 0_i64
until queue.empty?
  x, y, depth = queue.shift
  if x == x2 - 1 && y == y2 - 1
    p depth
    exit
  end
  1_i64.upto(k) do |i|
    break if x - i < 0 || visited[{x - i, y}] <= depth || css[y][x - i] == '@'
    if visited[{x - i, y}] > depth + 1
      visited[{x - i, y}] = depth + 1
      queue << {x - i, y, depth + 1}
    end
  end
  1_i64.upto(k) do |i|
    break if x + i >= w || visited[{x + i, y}] <= depth || css[y][x + i] == '@'
    if visited[{x + i, y}] > depth + 1
      visited[{x + i, y}] = depth + 1
      queue << {x + i, y, depth + 1}
    end
  end
  1_i64.upto(k) do |i|
    break if y - i < 0 || visited[{x, y - i}] <= depth || css[y - i][x] == '@'
    if visited[{x, y - i}] > depth + 1
      visited[{x, y - i}] = depth + 1
      queue << {x, y - i, depth + 1}
    end
  end
  1_i64.upto(k) do |i|
    break if y + i >= h || visited[{x, y + i}] <= depth || css[y + i][x] == '@'
    if visited[{x, y + i}] > depth + 1
      visited[{x, y + i}] = depth + 1
      queue << {x, y + i, depth + 1}
    end
  end
end
p -1
