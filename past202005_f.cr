# -*- contest: past202005-open -*-

n = read_line.to_i64
aiss = [] of Set(Char)
n.times do
  aiss << read_line.chars.to_set
end
ans = [] of Char
((n + 1) // 2).times do |i|
  if i == n - i - 1
    ans << aiss[i].first
    next
  end
  s = aiss[i] & aiss[n - i - 1]
  if s.empty?
    p -1
    exit
  else
    ans << s.first
  end
end
puts ans.join + ans[0...(n // 2)].reverse.join