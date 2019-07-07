gets
ais = read_line.split.map(&.to_i64)
ret = 0
sign = 1
ais.each do |a|
  ret += a * sign
  sign *= -1
end
answers = ais.map do |a|
  old_ret = ret
  ret = a * 2 - ret
  old_ret
end
puts answers.join(" ")
