# -*- mode: float -*-
require "math"

a, b, h, m = read_line.split.map(&.to_f64)
hx = Math.sin((h * 60.0 + m) / (60.0 * 6) * Math::PI) * a
hy = Math.cos((h * 60.0 + m) / (60.0 * 6) * Math::PI) * a
mx = Math.sin(m / 30.0 * Math::PI) * b
my = Math.cos(m / 30.0 * Math::PI) * b
p Math.sqrt((hx - mx) ** 2 + (hy - my) ** 2)
