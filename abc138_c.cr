# -*- mode: float -*-

gets
ais = read_line.split.map(&.to_f)
ais.sort!
while ais[1] != 100000.0
  ais[0] = (ais[0] + ais[1]) * 0.5
  ais[1] = 100000.0
  ais.sort!
end
puts ais[0]