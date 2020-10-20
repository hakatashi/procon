gets
s = read_line.chars
ans = s.count('R').to_i64 * s.count('G') * s.count('B')
s.each_with_index do |c, i|
  j = 1_i64
  while i + j * 2 < s.size
    ans -= 1 if Set{c, s[i + j], s[i + j * 2]}.size == 3
    j += 1
  end
end
p ans
