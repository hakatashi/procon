a, b, k = read_line.split.map(&.to_i)
p 100.downto(1).select {|n| a % n == 0 && b % n == 0}.to_a[k - 1]