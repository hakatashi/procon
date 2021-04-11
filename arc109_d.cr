`
def dist(ax, ay, bx, by)
  (ax - bx).abs + (ay - by).abs
end

def is_next(ax, ay, bx, by)
  dist(ax, ay, bx, by) == 1
end

def go_dir(x, y, dir)
  if dir == 0
    {x, y + 1}
  elsif dir == 1
    {x + 1, y}
  elsif dir == 2
    {x, y - 1}
  elsif dir == 3
    {x - 1, y}
  else
    {x, y}
  end
end

queue = Deque(Tuple(Int64, Int64, Int64, Int64)).new
queue << {0_i64, 0_i64, 0_i64, 0_i64}
visited = Set(Tuple(Int64, Int64, Int64)).new
dp = Array(Array(Array(Int64))).new(4) { Array(Array(Int64)).new(21) { Array(Int64).new(21, 0_i64) } }
until queue.empty?
  x, y, dir, depth = queue.shift
  next if x > 10 || x < -10 || y > 10 || y < -10
  next if visited.includes?({x, y, dir})
  visited << {x, y, dir}

  dp[dir][x + 10][y + 10] = depth

  queue << {x, y, (dir + 1) % 4, depth + 1}
  queue << {x, y, (dir - 1) % 4, depth + 1}
  nx, ny = go_dir(x, y, dir)
  queue << {nx, ny, (dir + 1) % 4, depth + 1}
  nx, ny = go_dir(x, y, dir)
  queue << {nx, ny, (dir + 2) % 4, depth + 1}
  nx, ny = go_dir(x, y, (dir + 1) % 4)
  queue << {nx, ny, (dir - 1) % 4, depth + 1}
  nx, ny = go_dir(x, y, (dir + 1) % 4)
  queue << {nx, ny, (dir + 2) % 4, depth + 1}
  nx, ny = go_dir(x, y, dir)
  nx, ny = go_dir(nx, ny, (dir + 1) % 4)
  queue << {nx, ny, (dir + 2) % 4, depth + 1}
end

dp.each do |table|
  table.each do |row|
    puts row.map {|n| n.to_s.rjust(2)}.join(' ')
  end
  puts "----"
end
`


def dist(ax, ay, bx, by)
  (ax - bx).abs + (ay - by).abs
end

def is_next(a, b)
  ax, ay = a
  bx, by = b
  dist(ax, ay, bx, by) == 1
end

def get_dir(dx, dy)
  if dx == 0 && dy == 1
    0_i64
  elsif dx == 1 && dy == 0
    1_i64
  elsif dx == 0 && dy == -1
    2_i64
  elsif dx == -1 && dy == 0
    3_i64
  else
    raise ""
  end
end

def go_dir(x, y, dir)
  if dir == 0
    {x, y + 1}
  elsif dir == 1
    {x + 1, y}
  elsif dir == 2
    {x, y - 1}
  elsif dir == 3
    {x - 1, y}
  else
    raise ""
  end
end

queue = Deque(Tuple(Int64, Int64, Int64, Int64)).new
queue << {0_i64, 0_i64, 0_i64, 0_i64}
visited = Set(Tuple(Int64, Int64, Int64)).new
dp = Array(Array(Array(Int64))).new(4) { Array(Array(Int64)).new(21) { Array(Int64).new(21, 0_i64) } }
until queue.empty?
  x, y, dir, depth = queue.shift
  next if x > 10 || x < -10 || y > 10 || y < -10
  next if visited.includes?({x, y, dir})
  visited << {x, y, dir}

  dp[dir][x + 10][y + 10] = depth

  queue << {x, y, (dir + 1) % 4, depth + 1}
  queue << {x, y, (dir - 1) % 4, depth + 1}
  nx, ny = go_dir(x, y, dir)
  queue << {nx, ny, (dir + 1) % 4, depth + 1}
  nx, ny = go_dir(x, y, dir)
  queue << {nx, ny, (dir + 2) % 4, depth + 1}
  nx, ny = go_dir(x, y, (dir + 1) % 4)
  queue << {nx, ny, (dir - 1) % 4, depth + 1}
  nx, ny = go_dir(x, y, (dir + 1) % 4)
  queue << {nx, ny, (dir + 2) % 4, depth + 1}
  nx, ny = go_dir(x, y, dir)
  nx, ny = go_dir(nx, ny, (dir + 1) % 4)
  queue << {nx, ny, (dir + 2) % 4, depth + 1}
end

t = read_line.to_i64
t.times do
  ax, ay, bx, by, cx, cy = read_line.split.map(&.to_i64)
  a = {ax, ay}
  b = {bx, by}
  c = {cx, cy}
  if is_next(a, b) && is_next(a, c)
    # nop
  elsif is_next(b, a) && is_next(b, c)
    ax, ay, bx, by, cx, cy = bx, by, ax, ay, cx, cy
  elsif is_next(c, a) && is_next(c, b)
    ax, ay, bx, by, cx, cy = cx, cy, ax, ay, bx, by
  end
  b_dir = get_dir(bx - ax, by - ay)
  c_dir = get_dir(cx - ax, cy - ay)
  if (b_dir + 1) % 4 == c_dir
    dir = b_dir
  elsif (c_dir + 1) % 4 == b_dir
    dir = c_dir
  else
    raise ""
  end

  if ax <= 10 && ax >= -10 && ay <= 10 && ay >= -10
    p dp[dir][ax + 10][ay + 10]
    next
  end

  if ax.abs == ay.abs
    p dp[dir][ax > 10 ? 20 : 0][ay > 10 ? 20 : 0] + (ax.abs - 10) * 2
  elsif ax.abs > ay.abs
    p dp[dir][ax > 10 ? 20 : 0][10] + (ax.abs - 10) * 2
  else
    p dp[dir][10][ay > 10 ? 20 : 0] + (ay.abs - 10) * 2
  end
end