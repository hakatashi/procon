n = read_line.to_i
s = read_line
ret = s.chars.map do |c|
  ((c.ord - 'A'.ord + n) % 26 + 'A'.ord).chr
end
puts ret.join