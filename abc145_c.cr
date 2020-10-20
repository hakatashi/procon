# -*- mode: float -*-
require "math"
n = read_line.to_i
towns = [] of Tuple(Int32, Int32)
n.times do
  x, y = read_line.split.map(&.to_i)
  towns << {x, y}
end
ret = 0.0
count = 0
towns.each_permutation do |perm|
  perm.each_cons(2) do |(a, b)|
    ax, ay = a
    bx, by = b
    ret += Math.sqrt((ax - bx) ** 2 + (ay - by) ** 2)
  end
  count += 1
end
p ret / count
