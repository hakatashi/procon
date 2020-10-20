gets
ss = STDIN.gets_to_end.split
ret = 0_u64
map = Hash(String, UInt64).new
ss.each do |s|
  ns = s.chars.sort.join
  unless map.has_key? ns
    map[ns] = 0_u64
  end
  map[ns] += 1
end
ret = 0_u64
map.each do |v|
  s, a = v
  ret += a * (a - 1) // 2
end
p ret
