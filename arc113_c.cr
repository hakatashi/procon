s = read_line.reverse
cnt = Hash(Char, Int32).new(0_i64)
ans = 0_i64
s.chars.each.with_index.each_cons_pair do |(a, i), (b, j)|
  if a == b
    ans += i - cnt[a]
    cnt.clear
    cnt[a] = i
  end
  cnt[a] += 1
end
p ans