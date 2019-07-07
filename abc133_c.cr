l, r = read_line.split.map(&.to_i64)
possibilities = Set(Int64).new
i = l
until possibilities.includes?(i % 2019) || i > r
  possibilities << i % 2019
  i += 1
end
r = possibilities.to_a.combinations(2).map do |c|
  a, b = c
  a * b % 2019
end.min
p r
