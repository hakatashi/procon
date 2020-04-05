gets
xs = read_line.split(" ").map(&.to_u64)
xs_with_index = xs.map_with_index { |x, i| [i, x] } .to_a.sort_by! do |xd|
  xd[1]
end
m = Hash(UInt64, UInt64).new
xs_with_index.each_with_index do |xd, sort_i|
  i, x = xd
  m[i.to_u64] = sort_i.to_u64
end
xs.size.times do |i|
  index = m[i]
  if index < xs.size // 2
    p xs_with_index[xs.size // 2][1]
  else
    p xs_with_index[xs.size // 2 - 1][1]
  end
end

