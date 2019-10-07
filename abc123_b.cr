a = read_line.to_i
b = read_line.to_i
c = read_line.to_i
d = read_line.to_i
e = read_line.to_i
dishes = [a, b, c, d, e]
p (dishes.map {|v| v.fdiv(10).ceil * 10}.sum - dishes.map {|v| (10 - v % 10) % 10}.max).to_i