require "set"

xs = Set.new
until xs.size >= 1000
  xs << rand(10000)
end
ys = Set.new
until ys.size >= 1000
  ys << rand(10000)
end
zs = Set.new
ws = Set.new
hash = Hash.new([])
xs.each do |x|
  ys.each do |y|
    zs << x + y
    ws << x - y
    hash[x + y] += [x - y]
  end
end
sizes = []
h = hash.to_a.sort_by do |k, v|
  v.size
end
new_ws = Set.new
new_zs = Set.new
points = []
h.reverse[0..300].each do |(z, v)|
  new_zs << z
  v.each do |w|
    new_ws << w
    x = (z + w) / 2
    y = (z - w) / 2
    points << [x, 10000 - y]
  end
  if new_ws.size > 10000
    puts points.size
    points.each do |(x, y)|
      puts "#{x} #{y}"
    end
    exit
  end
end