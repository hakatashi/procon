n, k = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)
sums = Array(Int64).new(ais.size + 1, 0_i64)
1.upto(ais.size) do |i|
  sums[i] = (sums[i - 1] + ais[i - 1] - 1 + k) % k
end
map = Hash(Int64, Array(Int32)).new
sums.each_with_index do |sum, i|
  unless map.has_key? sum
    map[sum] = [] of Int32
  end
  map[sum] << i
end
ret = 0_i64
map.each do |kk, v|
  v.each_with_index do |n, j|
    i = v.bsearch_index {|a| n - a < k}
    ret += j - i.not_nil!
  end
end
p ret
