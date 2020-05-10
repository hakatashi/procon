INF = 1_000_000_000_000_000_i64
n, m, x = read_line.split.map(&.to_i64)
books = [] of Tuple(Int64, Array(Int64))
n.times do
  tokens = read_line.split.map(&.to_i64)
  c = tokens[0]
  ais = tokens[1..]
  books << {c, ais}
end
ans = INF
Array.each_product([[true, false]] * n) do |pattern|
  a_sums = Array(Int64).new(m, 0_i64)
  c_sum = 0_i64
  books.each.with_index.select {|(book, i)| pattern[i]}.each do |(book, i)|
    c, ais = book
    ais.each_with_index do |a, i|
      a_sums[i] += a
    end
    c_sum += c
  end
  if a_sums.all? {|a| a >= x}
    if c_sum < ans
      ans = c_sum
    end
  end
end
if ans == INF
  p -1
else
  p ans
end
