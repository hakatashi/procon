n, k = read_line.split.map(&.to_i64)
ps = read_line.split.map(&.to_i64)
cs = read_line.split.map(&.to_i64)
ans = -1_000_000_000_000_000_000_i64
n.times do |i|
  pos = i
  ret = 0_i64
  j = 0_i64
  while j < k
    j += 1
    pos = ps[pos] - 1
    ret += cs[pos]
    if ans < ret
      ans = ret
    end
    if pos == i
      if ret > 0
        loops = k // j
        if loops >= 2
          ret = (loops - 1) * ret
          j = (loops - 1) * j
          if ans < ret
            ans = ret
          end
        end
      else
        break
      end
    end
  end
end
p ans
