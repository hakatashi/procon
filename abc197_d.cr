# -*- mode: float -*-

require "math"

n = read_line.to_i64
x0, y0 = read_line.split.map(&.to_f64)
xn, yn = read_line.split.map(&.to_f64)

cx = (x0 + xn) / 2
cy = (y0 + yn) / 2
r = Math.sqrt((xn - x0) ** 2 + (yn - y0) ** 2) / 2
theta = Math.atan2(y0 - yn, x0 - xn)
theta0 = theta + Math::PI / (n / 2)

x = cx + Math.cos(theta0) * r
y = cy + Math.sin(theta0) * r

puts "#{x} #{y}"
