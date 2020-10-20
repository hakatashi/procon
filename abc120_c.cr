s = read_line
r = s.chars.count { |c| c == '0' }
b = s.chars.count { |c| c == '1' }
p [r, b].min * 2
