def extended_gcd(a, b)
  last_remainder, remainder = a.abs, b.abs
  x, last_x, y, last_y = 0_i64, 1_i64, 1_i64, 0_i64
  while remainder != 0
    new_last_remainder = remainder
    quotient, remainder = last_remainder.divmod(remainder)
    last_remainder = new_last_remainder
    x, last_x = last_x - quotient * x, x
    y, last_y = last_y - quotient * y, y
  end

  last_remainder
end

gets
ais = read_line.split.map(&.to_i64)
left_gcds = [] of Int64
right_gcds = [] of Int64
left_gcds << ais[0]
ais.each_with_index do |a, i|
  next if i == 0
  left_gcds << extended_gcd(left_gcds.last, a)
end
right_gcds << ais.last
ais.reverse.each_with_index do |a, i|
  next if i == 0
  right_gcds << extended_gcd(right_gcds.last, a)
end
max = [left_gcds[-2], right_gcds[-2]].max
1_i64.upto(ais.size - 2) do |i|
  max = [max, extended_gcd(left_gcds[i - 1], right_gcds[ais.size - i - 2])].max
end
p max
