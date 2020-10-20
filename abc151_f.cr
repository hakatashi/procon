# -*- mode: float -*-

require "math"

n = read_line.to_i64
points = Array(Tuple(Float64, Float64)).new
n.times do |i|
  x, y = read_line.split.map(&.to_i64.to_f64)
  points << {x, y}
end

def dist(ax, ay, bx, by)
  Math.sqrt((ax - bx) ** 2 + (ay - by) ** 2)
end

ans = 20000.to_f64

0.upto(n - 1) do |a|
  ax, ay = points[a]
  (a + 1).upto(n - 1) do |b|
    bx, by = points[b]
    r = dist(ax, ay, bx, by) / 2.0
    px = (ax + bx) / 2.0
    py = (ay + by) / 2.0
    if r < ans && points.all? { |(zx, zy)| dist(px, py, zx, zy) <= r + 0.000000001 }
      ans = r
    end
  end
end

if n >= 3
  0.upto(n - 1) do |ra|
    ax, ay = points[ra]
    (ra + 1).upto(n - 1) do |rb|
      bx, by = points[rb]
      (rb + 1).upto(n - 1) do |rc|
        cx, cy = points[rc]

        if ax == bx && bx == cx
          next
        end

        if ay == by && by == cy
          next
        end

        if (ax - bx) * (ay - cy) == (ax - cx) * (ay - by)
          next
        end

        r = dist(ax, ay, bx, by) / 2.0

        a = ax
        b = ay
        c = bx
        d = by
        e = cx
        f = cy

        aa = a * a
        bb = b * b
        cc = c * c
        dd = d * d
        ee = e * e
        ff = f * f

        py = ((e - a) * (aa + bb - cc - dd) - (c - a) * (aa + bb - ee - ff)) / (2 * (e - a) * (b - d) - 2 * (c - a) * (b - f))
        if c == a
          px = (2 * (b - f) * py - aa - bb + ee + ff) / (2 * (e - a))
        else
          px = (2 * (b - d) * py - aa - bb + cc + dd) / (2 * (c - a))
        end

        r = dist(px, py, a, b)

        if r < ans && points.all? { |(zx, zy)| dist(px, py, zx, zy) <= r + 0.000000001 }
          ans = r
        end
      end
    end
  end
end

printf("%.8f\n", ans)
