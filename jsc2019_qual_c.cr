MOD = 1000000007_u64

gets
s = read_line
ret = 1_u64
prev_color = 'W'
is_prev_start = true
unmatched_starts = 0
s.chars.each do |c|
  if c == prev_color
    is_start = !is_prev_start
  else
    is_start = is_prev_start
  end

  if is_start
    unmatched_starts += 1
  else
    if unmatched_starts == 0
      puts "0"
      exit
    end
    ret = (ret * unmatched_starts) % MOD
    unmatched_starts -= 1
  end

  prev_color = c
  is_prev_start = is_start
end

(s.size // 2).times do |i|
  ret = (ret * (i + 1)) % MOD
end

if unmatched_starts == 0
  puts ret
else
  puts "0"
end
