s = read_line
t = read_line
ans = 0_i64.upto((s.size - t.size).to_i64).min_of do |i|
  cnt = 0_i64
  t.size.to_i64.times do |j|
    if s[j + i] != t[j]
      cnt += 1
    end
  end
  cnt
end
p ans