# -*- mode: float -*-

gets
sign = 1
area = 0.0
STDIN.gets_to_end.split(/\s/).reject(&.empty?).map(&.to_i).sort.reverse.each do |a|
  area += a * a * Math::PI * sign
  sign *= -1
end
p area
