x, y, a, b, c = read_line.split.map(&.to_i64)
ps = read_line.split.map(&.to_i64).sort!.reverse!
qs = read_line.split.map(&.to_i64).sort!.reverse!
rs = read_line.split.map(&.to_i64).sort!.reverse!

ans = ps[0...x].sum + qs[0...y].sum
ptr_p = x
ptr_q = y
ptr_r = 0_i64
loop do
  updated = false
  break if ptr_p == 0 && ptr_q == 0

  if ptr_q == 0 || ps[ptr_p - 1] < qs[ptr_q - 1]
    if ptr_p > 0 && ptr_r < rs.size && ps[ptr_p - 1] < rs[ptr_r]
      ans += rs[ptr_r] - ps[ptr_p - 1]
      ptr_p -= 1
      ptr_r += 1
      updated = true
    end
  else
    if ptr_q > 0 && ptr_r < rs.size && qs[ptr_q - 1] < rs[ptr_r]
      ans += rs[ptr_r] - qs[ptr_q - 1]
      ptr_q -= 1
      ptr_r += 1
      updated = true
    end
  end
  unless updated
    break
  end
end
p ans
