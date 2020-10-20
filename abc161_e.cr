n, k, c = read_line.split.map(&.to_i64)
s = read_line.chars

ldp = Array(Int64).new(s.size, 0_i64)
prev_work = -1_000_000_000_i64
cnt = 0_i64
s.each_with_index do |ch, i|
  if ch == 'o' && prev_work + c < i
    cnt += 1
    prev_work = i
  end
  ldp[i] = cnt
end

rdp = Array(Int64).new(s.size, 0_i64)
prev_work = 1_000_000_000_i64
cnt = 0_i64
(s.size.to_i64 - 1).downto(0_i64) do |i|
  ch = s[i]
  if ch == 'o' && prev_work - c > i
    cnt += 1
    prev_work = i
  end
  rdp[i] = cnt
end

n.times do |i|
  left = i == 0 ? 0_i64 : ldp[i - 1]
  right = i == s.size - 1 ? 0_i64 : rdp[i + 1]
  if left + right < k
    p i + 1
  end
end
