n = read_line.to_i64
h = Hash(Tuple(Char, Char), Int64).new(0_i64)
n.times do |i|
  s = (i + 1).to_s.chars
  h[{s.first, s.last}] += 1
end
ans = 0_i64
h.each_key do |(first, last)|
  ans += h[{first, last}] * h[{last, first}]
end
p ans