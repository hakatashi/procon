n, q = read_line.split.map(&.to_i64)
cs = read_line.split.map(&.to_i64)
queries = [] of Tuple(Int64, Int64)
q.times do
  l, r = read_line.split.map(&.to_i64)
  queries << {l, r}
end
sqrt_n = (1_i64..n).bsearch { |i| i * i >= n }
queries.sort_by! do |(l, r)|
  {l // sqrt_n, r}
end
d = Array(Int64).new(0_i64, (n - 1) // sqrt_n + 1)
