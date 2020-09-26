@[AlwaysInline]
def max(a, b)
  a > b ? a : b
end

@[AlwaysInline]
def max(a, b, c)
  max(a, max(b, c))
end

n = read_line.to_i64
queries = [] of Tuple(Int64, Int64)
query_dict = Hash(Int64, Int64).new
n.times do |i|
  x, y = read_line.split.map(&.to_i64)
  queries << {x - 1, y - 1}
  query_dict[x - 1] = i
end
queries.sort_by! {|(x, y)| x}
acc = 0_i64
box_count = 0_i64
box_size = 0_i64
ans = Array(Int64).new(n, 0_i64)
queries.each_with_index do |(x, y), j|
  dx = x - acc + 1
  dy = n - acc - y
  box_size = max(box_size, dx, dy)
  box_count += 1
  if box_count == box_size
    acc.upto(acc + box_size - 1) do |i|
      ans[query_dict[i]] = box_size
    end
    acc += box_size
    box_count = 0
    box_size = 0_i64
  end
end
ans.each do |v|
  p v
end
