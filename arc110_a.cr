n = read_line.to_i64
p (2_i64..n).to_a.reduce {|a, b| a.lcm(b)} + 1