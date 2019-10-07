n = read_line.to_i64
a = read_line.to_i64
b = read_line.to_i64
c = read_line.to_i64
d = read_line.to_i64
e = read_line.to_i64
transports = [a, b, c, d, e]
p n.fdiv([a, b, c, d, e].min).ceil.to_i64 + 4