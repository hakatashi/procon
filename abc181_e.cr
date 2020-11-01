n, m = read_line.split.map(&.to_i64)
hs = read_line.split.map(&.to_i64).sort!
ws = read_line.split.map(&.to_i64).sort!
left_sum = Array(Int64).new(n + 1, 0_i64)
right_sum = Array(Int64).new(n + 1, 0_i64)
left_sum[0] = 0_i64
hs.each_with_index do |h, i|
  if i % 2 == 1
    left_sum[i + 1] = left_sum[i] + h - hs[i - 1]
  else
    left_sum[i + 1] = left_sum[i]
  end
end
right_sum[n] = 0_i64
hs.reverse.each_with_index do |h, ri|
  i = n - ri - 1
  if i % 2 == 1
    right_sum[i] = right_sum[i + 1] + hs[i + 1] - h
  else
    right_sum[i] = right_sum[i + 1]
  end
end
ans = Int64::MAX
ws.each do |w|
  next_index = hs.bsearch_index {|h| h >= w}
  if next_index.nil?
    ret = w - hs[n - 1] + left_sum[n]
  else
    if next_index % 2 == 0
      ret = hs[next_index] - w + left_sum[next_index] + right_sum[next_index + 1]
    else
      ret = w - hs[next_index - 1] + left_sum[next_index - 1] + right_sum[next_index]
    end
  end
  if ans > ret
    ans = ret
  end
end
p ans
