# -*- mode: float -*-

def get_point(hands)
  counts = [0_i64] * 10
  hands.each {|hand| counts[hand] += 1}
  ret = 0_i64
  counts.each_with_index do |count, i|
    ret += i * 10_i64 ** count
  end
  ret
end

k = read_line.to_i64
ss = read_line.chars[0...4].map(&.to_i64)
ts = read_line.chars[0...4].map(&.to_i64)

counts = [0_i64] + [k] * 9
ss.each {|s| counts[s] -= 1}
ts.each {|t| counts[t] -= 1}

sum = counts.sum

ans = 0.0_f64
1_i64.upto(9_i64) do |i|
  1_i64.upto(9_i64) do |j|
    s_points = get_point(ss + [i])
    t_points = get_point(ts + [j])
    next unless s_points > t_points

    if i == j
      next unless counts[i] >= 2
      ans += counts[i] * (counts[i] - 1) / sum / (sum - 1)
    else
      ans += counts[i] * counts[j] / sum / (sum - 1)
    end
  end
end

p ans