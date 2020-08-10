start = Time.utc

d = read_line.to_i64
cs = read_line.split.map(&.to_i64)
sss = [] of Array(Int64)
d.times do
  sss << read_line.split.map(&.to_i64)
end

max = [] of Int64
maxans = 0_i64
last = cs.map { 0_i64 }
d.times do |i|
  base = last.map_with_index {|l, j| -cs[j] * (i - l + 1)} .sum
  best = base
  best_choice = 0_i64
  last.each_with_index do |l, j|
    ret = base + cs[j] * (i - l + 1) + sss[i][j]
    if ret > best
      best = ret
      best_choice = j.to_i64
    end
  end
  maxans += best
  max << best_choice + 1
  last[best_choice] = i.to_i64 + 1
end

dp1 = Array(Array(Int64)).new(d + 2) { Array(Int64).new(26, -1_i64) }
dp2 = Array(Array(Int64)).new(d + 2) { Array(Int64).new(26, d) }
until start < 1.9.seconds.ago
  d.times do |target|
    break if start < 1.9.seconds.ago
    ans = maxans
    # find before
    last = -1_i64
    (target - 1).downto(0_i64) do |i|
      if max[i] == max[target]
        last = i
        break
      end
    end
    # find after
    nex = d
    (target + 1).upto(d - 1) do |i|
      if max[i] == max[target]
        nex = i
        break
      end
    end
    ans -= (target - last) * (nex - target) * cs[max[target] - 1]
    ans -= sss[target][max[target] - 1]
    26_i64.times do |i|
      # find before
      last = -1_i64
      (target - 1).downto(0_i64) do |j|
        if max[j] == i + 1
          last = j
          break
        end
      end
      # find after
      nex = d
      (target + 1).upto(d - 1) do |j|
        if max[j] == i + 1
          nex = j
          break
        end
      end
      ret = ans + (target - last) * (nex - target) * cs[i] + sss[target][i]
      if ret > maxans
        maxans = ret
        max[target] = i + 1
      end
    end
  end
  break if start < 1.9.seconds.ago
  1_i64.upto(d) do |i|
    26_i64.times do |j|
      if max[i - 1] == j + 1
        dp1[i][j] = i - 1
      else
        dp1[i][j] = dp1[i - 1][j]
      end
    end
  end
  d.downto(1_i64) do |i|
    26_i64.times do |j|
      if max[i - 1] == j + 1
        dp2[i][j] = i - 1
      else
        dp2[i][j] = dp2[i + 1][j]
      end
    end
  end
  (d - 1).times do |i|
    f1 = (dp2[i + 2][max[i] - 1] - dp1[i][max[i] - 1] + 1) * cs[max[i] - 1]
    f2 = (dp2[i + 3][max[i + 1] - 1] - dp1[i + 1][max[i + 1] - 1] + 1) * cs[max[i + 1] - 1]
    f3 = sss[i][max[i] - 1] + sss[i + 1][max[i + 1] - 1]
    f4 = sss[i + 1][max[i] - 1] + sss[i][max[i + 1] - 1]
    if -f1 + f2 - f3 + f4 > 0
      max[i], max[i + 1] = max[i + 1], max[i]
    end
  end
end
max.each do |m|
  p m
end