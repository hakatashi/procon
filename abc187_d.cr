n = read_line.to_i64
cities = [] of Tuple(Int64, Int64)
n.times do
  b, a = read_line.split.map(&.to_i64)
  cities << {a, b}
end
cities.sort_by! {|(a, b)| a + b * 2}
sum_a = 0_i64
sum_b = cities.map {|(a, b)| b}.sum
cities.reverse_each.with_index do |(a, b), i|
  sum_b -= b
  sum_a += a + b
  if sum_a > sum_b
    p i + 1
    exit
  end
end
