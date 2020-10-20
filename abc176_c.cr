gets
ais = read_line.split.map(&.to_i64)
ret = 0_i64
ans = 0_i64
ais.each do |a|
  if ret > a
    ans += ret - a
  else
    ret = a
  end
end
p ans
