n, k = read_line.split.map(&.to_u64)
ais = read_line.split.map(&.to_u64)
indices_list = Hash(UInt64, Array(UInt64)).new
ais.each_with_index do |a, i|
  unless indices_list.has_key? a
    indices_list[a] = [] of UInt64
  end
  indices_list[a] << i.to_u64
end
i = 0_u64
list = [0_u64]
markers = [0_u64]
loop do
  indices = indices_list[ais[i]]
  next_index = indices.bsearch {|ni| ni > i}
  if next_index.nil?
    next_index = indices[0]
    markers << list.size.to_u64
  end
  i = (next_index + 1) % ais.size
  break if i == 0_u64
  list << i
end
start_point = list[(markers[k % markers.size] + list.size - 1) % list.size]
ret = [] of UInt64
i2 = start_point
while i2 < ais.size
  indices = indices_list[ais[i2]]
  next_index = indices.bsearch {|ni| ni > i2}
  if next_index.nil?
    ret << ais[i2]
    i2 += 1
  else
    i2 = next_index + 1
  end
end
puts ret.join(" ")
