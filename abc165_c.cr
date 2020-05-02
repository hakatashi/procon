n, m, q = read_line.split.map(&.to_i64)
queries = [] of Tuple(Int64, Int64, Int64, Int64)
q.times do
  a, b, c, d = read_line.split.map(&.to_i64)
  queries << {a, b, c, d}
end
ans = (1_i64..(n + m - 1)).to_a.each_combination(n).max_of do |ais|
  ais.map_with_index! {|c, i| c - i}
  queries.sum do |(a, b, c, d)|
    ais[b - 1] - ais[a - 1] == c ? d : 0_i64
  end
end
p ans
