s = read_line
p (s.size // 2).times.count {|i| s[i] != s[s.size - i - 1]}