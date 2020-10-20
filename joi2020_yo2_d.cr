# -*- contest: joi2020yo2 -*-

precedings = [
  [1],
  [0, 2, 4],
  [1, 3, 5],
  [2, 6],
  [1, 5, 7],
  [2, 4, 6, 8],
  [3, 5, 9],
  [4, 8],
  [5, 7, 9],
  [6, 8],
]

m, r = read_line.split.map(&.to_i)
queue = Deque(Tuple(Int32, Int32, Int32)).new(m * 10)
queue << {0, 0, 0} # pos, mod, dist
visited = Set(Int32).new
visited << 0
cnt = 0
until queue.empty?
  pos, mod, dist = queue.shift
  if mod == r
    p dist
    exit
  end
  precedings[pos].each do |preceding|
    unless visited.includes?(preceding * m + mod)
      visited << preceding * m + mod
      queue << {preceding, mod, dist + 1}
    end
  end
  new_mod = (mod * 10 + pos) % m
  unless visited.includes?(pos * m + new_mod)
    visited << pos * m + new_mod
    queue << {pos, new_mod, dist + 1}
  end
end
