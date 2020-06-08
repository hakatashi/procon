t = read_line
ans = 0_i64
removed = 0_i64
t.chars.each_with_index do |c, i|
  if c == '0'
    if (i - removed) % 2 == 0
      removed += 1
    end
  else
    ans += i // 2 - (i - removed) // 2
    if (i - removed) % 2 == 0
      ans += t.size.to_i64 - i.to_i64
    end
  end
end
p ans
