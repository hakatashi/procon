def lcp(*strs)
  return 0 if strs.empty?
  min, max = strs.minmax
  i = min.size.times { |i| break i if min[i] != max[i] }
  i.nil? ? min.size : i
end

gets
s = read_line

ret = 0
s.size.times do |i|
  next if i == 0
  slice = s.byte_slice(i)
  subs = i.times.map do |j|
    len = [i - j, s.size - i].min
    s.byte_slice(j, len)
  end.to_a.uniq.sort
  index = subs.bsearch_index { |sub| sub >= slice }
  if index.nil?
    ret = [ret, lcp(slice, subs.last)].max
  else
    ret = [ret, lcp(slice, subs[index])].max
    if index > 0
      ret = [ret, lcp(slice, subs[index - 1])].max
    end
  end
end

puts ret
