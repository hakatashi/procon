# -*- status: pending -*-

require "big"

struct BigRational
  def **(n)
    raise ArgumentError.new if n != 2
    self * self
  end
end

# a + sqrt(b)
alias SqrtNum = Tuple(Int64, Int64)

n, k = read_line.split.map(&.to_i64)
meats = [] of Tuple(Int64, Int64, Int64)
n.times do
  x, y, c = read_line.split.map(&.to_i64)
  meats << {x, y, c}
end
ans = (0_i64..Int64::MAX).bsearch do |rt|
  t = BigRational.new(rt, Int32::MAX)
  [
    meats.map do |(x, y, c)|
      { {x, 0_i64}, {y, 0_i64} }
    end,
    meats.each_combination(2).map do |(meat_a, meat_b)|
      ax, ay, ac = meat_a
      bx, by, bc = meat_b
      ar, br = t // ac, t // bc
      dx, dy = ax - bx, ay - by
      if (ax - bx) ** 2 + (ay - by) ** 2 > (ar + br) ** 2
        next ([] of Tuple(SqrtNum, SqrtNum)).each
      end
      # https://shogo82148.github.io/homepage/memo/geometry/circle-cross.html
      cf1 = (dx ** 2 + dy ** 2 + ar ** 2 - br ** 2) // 2
      cf2 = (dx ** 2 + dy ** 2) * ar ** 2 - cf1 ** 2
      cf3 = dx ** 2 + dy ** 2
      if cf2 < 0
        next ([] of Tuple(SqrtNum, SqrtNum)).each
      end
      [
        { {cf1 * dx // cf3, dy // cf3, cf2}, {cf1 * dy // cf3, -dx // cf3, cf2} },
        { {cf1 * dx // cf3, -dy // cf3, cf2}, {cf1 * dy // cf3, dx // cf3, cf2} },
      ].each
    end,
  ].each.flatten.any? do |(x, y)|
    cnt = meats.count { |(cx, cy, c)| (x - cx) ** 2 + (y - cy) ** 2 <= (t // c) ** 2 }
    pp [t, x, y, cnt]
    cnt >= k
  end
end
p ans
