s = read_line
rs = s.scan(/(R+|L+)/).map do |m|
  m[0]
end
ret = Array(UInt64).new(s.size, 0_u64)
i = 0_u64
rs.each do |r|
  if r[0] == 'R'
    ret[i + r.size - 1] += (r.size + 1) / 2
    ret[i + r.size] += r.size / 2
  else
    ret[i] += (r.size + 1) / 2
    ret[i - 1] += r.size / 2
  end
  i += r.size
end
puts ret.join(" ")
