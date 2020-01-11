n, m = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64).sort.reverse
sums = [0_i64]
ais.each do |a|
  sums << sums.last + a
end

ret = (0..(ais.first * 2 + 1)).bsearch do |i|
  count = 0_i64
  ais.each_with_index do |a, j|
    search = ais.bsearch_index {|a2| a2 < i - a}
    if search.nil?
      count += n
    else
      count += search
    end
  end
  count <= m
end.not_nil! - 1

pushed = 0_i64
ans = 0_i64

ais.each_with_index do |a, j|
  search1 = ais.bsearch_index {|a2| a2 <= ret - a}
  search2 = ais.bsearch_index {|a2| a2 < ret - a}
  if search1.nil?
    search1 = n
  end
  pushed += search1
  ans += sums[search1] + a * search1
end

ans += (m - pushed) * ret
p ans
