gets
ais = read_line.split.map(&.to_i)
puts ais.each_with_index.to_a.sort_by { |a, i| a }.map { |a, i| i + 1 }.join(" ")
