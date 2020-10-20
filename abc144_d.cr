# -*- mode: float -*-
a, b, x = read_line.split.map(&.to_f)
if x >= a * a * b / 2.0
  p Math.atan2((b - x / a / a) * 2.0, a) / Math::PI * 180.0
else
  p 90.0 - Math.atan2(x / a / b * 2.0, b) / Math::PI * 180.0
end
