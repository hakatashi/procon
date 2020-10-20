gets
hs = read_line.split.map(&.to_i)
ret = 0
hs.each_with_index do |h, i|
  if hs[0..i].all? { |h2| h2 <= h }
    ret += 1
  end
end
p ret
