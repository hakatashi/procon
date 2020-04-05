def maximize(i, cv, cw, loads, total)
  if i == loads.size
    return cv
  end
  if cw + loads[i][:w] > total
    return maximize(i + 1, cv, cw, loads, total)
  end
  [
    maximize(i + 1, cv + loads[i][:v], cw + loads[i][:w], loads, total),
    maximize(i + 1, cv, cw, loads, total)
  ].max
end

n, total = read_line.split(' ').map(&.to_i)
max_v = 0_u64
max_w = 0_u64
loads = STDIN.gets_to_end.split('\n').reject(&.empty?).map do |line|
  v, w = line.split(' ').map(&.to_u64)
  max_v = [max_v, v].max
  max_w = [max_w, w].max
  {v: v, w: w}
end
if loads.size <= 30
  puts maximize(0_u64, 0_u64, 0_u64, loads, total)
  exit
end
if max_w <= 1000
  dp = Array.new([200 * 1000, total + 1].max, 0_u64)
  loads.each do |l|
    (dp.size - 1).downto(0) do |i|
      if dp[i] != 0 && i + l[:w] <= total
        dp[i + l[:w]] = [dp[i + l[:w]], dp[i] + l[:v]].max
      end
    end
    dp[l[:w]] = [dp[l[:w]], l[:v]].max
  end
  puts dp.max
  exit
end