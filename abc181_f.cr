# -*- mode: float -*-
n = read_line.to_i64
points = [] of Tuple(Int64, Int64)
n.times do
  x, y = read_line.split.map(&.to_i64)
  points << {x, y}
end
if n == 1
  x, y = points[0]
  p [y + 100, 100 - y].max / 2
  exit
end
upper_points = Set(Tuple(Int64, Int64)).new
downer_points = points.to_set
uppest_point = downer_points.max_by {|(x, y)| y}
downest_point = downer_points.min_by {|(x, y)| y}
ans = [100.0 - uppest_point[1], 100.0 + downest_point[1]].max
upper_points << uppest_point
downer_points.delete(uppest_point)
until downer_points.empty?
  ret = 10000.0
  ret1 = 10000.0
  nearest_point = nil
  downer_points.each do |(ax, ay)|
    if 100.0 - ay < ret
      ret = 100.0 - ay
    end
    if 100.0 - ay < ret1
      ret1 = 100.0 - ay
      nearest_point = {ax, ay}
    end
    upper_points.each do |(bx, by)|
      if 100.0 + by < ret
        ret = 100.0 + by
      end
      ret2 = Math.sqrt(((ax - bx) ** 2 + (ay - by) ** 2).to_f)
      if ret2 < ret1
        ret1 = ret2
        nearest_point = {ax, ay}
      end
      if ret2 < ret
        ret = ret2
      end
    end
  end
  if ans < ret
    ans = ret
  end
  upper_points << nearest_point.not_nil!
  downer_points.delete(nearest_point.not_nil!)
end
p ans / 2
