require "big"

ra, rb = read_line.split
a = ra.to_i64
b = rb.gsub(".", "").to_i64
p a * b // 100
