n, m = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64).sort!.reverse!
sum = ais.sum
ret = 0_i64
ais.each_with_index do |a, i|
  if i < m && a * m * 4 >= sum
    ret += 1
  end
end
puts ret >= m ? "Yes" : "No"
