n = read_line.to_i64
ans = 1_i64.upto(n).count do |i|
  !i.to_s.includes?('7') && !i.to_s(8).includes?('7')
end
p ans