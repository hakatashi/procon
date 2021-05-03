n, m = read_line.split.map(&.to_i64)
xsets = Set(Int64).new
ysets = Set(Int64).new
vers = [] of Tuple(Int64, Int64, Int64)
hors = [] of Tuple(Int64, Int64, Int64)
n.times do
  a, b, c = read_line.split.map(&.to_i64)
  ysets << a
  ysets << b
  xsets << c
  vers << {a, b, c}
end
m.times do
  d, e, f = read_line.split.map(&.to_i64)
  ysets << d
  xsets << e
  xsets << f
  hors << {d, e, f}
end

xs = xsets.to_a.sort!
ys = ysets.to_a.sort!
w = xs.size.to_i64 + 1
h = ys.size.to_i64 + 1

alias XY = Tuple(Int64, Int64)

barriers = Hash(XY, Set(XY)).new(w * h) do |h, k|
  h[k] = Set(XY).new
end

vers.each do |(a, b, c)|
  ai = ys.bsearch_index { |y| y >= a }.not_nil!.to_i64
  bi = ys.bsearch_index { |y| y >= b }.not_nil!.to_i64
  ci = xs.bsearch_index { |x| x >= c }.not_nil!.to_i64
  (ai + 1).upto(bi) do |yi|
    barriers[{ci, yi}] << {ci + 1, yi}
    barriers[{ci + 1, yi}] << {ci, yi}
  end
end

hors.each do |(d, e, f)|
  di = ys.bsearch_index { |y| y >= d }.not_nil!.to_i64
  ei = xs.bsearch_index { |x| x >= e }.not_nil!.to_i64
  fi = xs.bsearch_index { |x| x >= f }.not_nil!.to_i64
  (ei + 1).upto(fi) do |xi|
    barriers[{xi, di}] << {xi, di + 1}
    barriers[{xi, di + 1}] << {xi, di}
  end
end

startx = xs.bsearch_index { |x| x > 0 }
starty = ys.bsearch_index { |y| y > 0 }

if startx.nil? || starty.nil?
  puts "INF"
  exit
end

start = {startx.to_i64, starty.to_i64}

queue = Deque(XY).new
queue << start
visited = Set(XY).new
visited << start
ans = 0_i64

macro go(condition, cell)
  if {{condition}} && !visited.includes?({{cell}}) && !barriers[{x, y}].includes?({{cell}})
    queue << {{cell}}
    visited << {{cell}}
  end
end

until queue.empty?
  x, y = queue.shift
  if x == 0 || y == 0
    puts "INF"
    exit
  end
  ans += (xs[x] - xs[x - 1]) * (ys[y] - ys[y - 1])
  go(x - 1 >= 0, {x - 1, y})
  go(x + 1 < w, {x + 1, y})
  go(y - 1 >= 0, {x, y - 1})
  go(y + 1 < h, {x, y + 1})
end
p ans
