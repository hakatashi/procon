h, w = read_line.split.map(&.to_i64)
map = [] of String
portals = Array(Array(Tuple(Int64, Int64))).new(26) { [] of Tuple(Int64, Int64) }
start = {0_i64, 0_i64}
goal = {0_i64, 0_i64}
h.times do |y|
  line = read_line
  line.each_char_with_index do |c, x|
    if c == 'S'
      start = {x.to_i64, y.to_i64}
    elsif c == 'G'
      goal = {x.to_i64, y.to_i64}
    elsif !(c == '#' || c == '.')
      portals[c - 'a'] << {x.to_i64, y.to_i64}
    end
  end
  map << line
end

queue = Deque(Tuple(Int64, Int64, Int64)).new
queue << {start[0], start[1], 0_i64}
visited = Set(Tuple(Int64, Int64)).new
used_portals = Set(Char).new

until queue.empty?
  x, y, depth = queue.shift
  next if map[y][x] == '#'

  if map[y][x] == 'G'
    p depth
    exit
  end

  if 'a' <= map[y][x] && map[y][x] <= 'z' && !used_portals.includes?(map[y][x])
    used_portals << map[y][x]
    portals[map[y][x] - 'a'].each do |portal|
      next if portal == {x, y}
      unless visited.includes?(portal)
        visited << portal
        queue << {portal[0], portal[1], depth + 1}
      end
    end
  end

  if x + 1 < w && !visited.includes?({x + 1, y})
    visited << {x + 1, y}
    queue << {x + 1, y, depth + 1}
  end
  if x - 1 >= 0 && !visited.includes?({x - 1, y})
    visited << {x - 1, y}
    queue << {x - 1, y, depth + 1}
  end
  if y + 1 < h && !visited.includes?({x, y + 1})
    visited << {x, y + 1}
    queue << {x, y + 1, depth + 1}
  end
  if y - 1 >= 0 && !visited.includes?({x, y - 1})
    visited << {x, y - 1}
    queue << {x, y - 1, depth + 1}
  end
end
p -1
