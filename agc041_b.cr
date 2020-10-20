# -*- status: pending -*-

n, m, v, pe = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64).sort.reverse
sums = [0]
rsums = [0]
ais.each do |a|
  sums << sums.last + a
end
ais.reverse.each do |a|
  rsums << rsums.last + a
end
ans = ais.bsearch_index do |a, i|
  if i < pe - 1
    false
  elsif a + m <= ais[pe - 1]
    true
  else
    s = ais.bsearch_index { |a2| a2 <= a + m }
    if s.nil? || s < pe - 1
      (pe - 1) * m + (i - (pe - 1)) * (a + m) - (sums[i] - sums[pe - 1]) + (n - i) * m <= m * v
    else
      (pe - 1) * m + (i - s) * (a + m) - (sums[i] - sums[s]) + (n - i) * m <= m * v
    end
  end
end
p ans
