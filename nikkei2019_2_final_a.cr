gets
ais = read_line.split.map(&.to_i64)
lefts = [] of Int64
sorted_ais = [1_i64 << 60]
ais.each do |a|
  index = sorted_ais.bsearch_index {|a2| a2 >= a} .not_nil!.to_i64
  lefts << index
  sorted_ais.insert(index, a)
end
rights = [] of Int64
sorted_ais = [1_i64 << 60]
ais.reverse_each do |a|
  index = sorted_ais.bsearch_index {|a2| a2 >= a} .not_nil!.to_i64
  rights.unshift(index)
  sorted_ais.insert(index, a)
end
ans = lefts.zip(rights).sum {|(left, right)| left * right}
p ans
