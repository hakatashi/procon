s = read_line
p [
  s.chars.each_with_index.count {|c, i| i % 2 == 0 ? c == '0' : c == '1'},
  s.chars.each_with_index.count {|c, i| i % 2 == 1 ? c == '0' : c == '1'},
].min