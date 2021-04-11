n = read_line
ans = Int64::MAX
(2_i64 ** n.size).times do |bits|
  new_n = n.chars.map_with_index do |c, i|
    if (bits >> i) & 1 == 1
      ""
    else
      c.to_s
    end
  end.join
  if new_n != "" && new_n.to_i64 % 3 == 0 && bits.popcount < ans
    ans = bits.popcount.to_i64
  end
end
if ans == Int64::MAX
  p -1
else
  p ans
end
