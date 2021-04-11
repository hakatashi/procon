# -*- mode: float -*-
n = read_line.to_i64
p (1...n).map {|i| n / i}.sum
