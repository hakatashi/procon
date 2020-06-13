n, k, s, t = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)

factors = Array(Int64).new(51_i64, 0_i64)
1_i64.upto(50_i64) do |i|
  n = 1_i64
  ret = 0_i64
  [k, i].min.times do |j|
    n *= i - j
    n //= j + 1
    ret += n
  end
  factors[i] = ret
end

new_ais = Array(Int64).new(ais.size, 0_i64)
width = 0_i64
18_i64.times do |i|
  if s.bit(i) == 1 && t.bit(i) == 0
    p 0
    exit
  elsif s.bit(i) == 1 && t.bit(i) == 1
    ais.each_with_index do |a, j|
      if a.bit(i) != 1
        new_ais[j] = -1_i64
      end
    end
  elsif s.bit(i) == 0 && t.bit(i) == 0
    ais.each_with_index do |a, j|
      if a.bit(i) != 0
        new_ais[j] = -1_i64
      end
    end
  else
    ais.each_with_index do |a, j|
      if new_ais[j] != -1
        new_ais[j] = (new_ais[j] << 1) + a.bit(i)
      end
    end
    width += 1
  end
end

new_ais.reject!(-1_i64)

ans = 0_i64
(1_i64 << width).times do |i|
  counts = Hash(Int64, Int64).new(0_i64)
  new_ais.each do |a|
    counts[a & i] += 1
  end
  ret = 0_i64
  counts.each do |k, v|
    ret += factors[v]
  end
  if i.popcount.even?
    ans += ret
  else
    ans -= ret
  end
end
p ans
