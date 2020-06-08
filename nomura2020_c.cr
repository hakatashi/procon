def min(a, b)
  a > b ? b : a
end

n = read_line.to_i64
ais = read_line.split.map(&.to_i64)

sums = Array(Int64).new(ais.size, 0_i64)
sum = 0_i64
ais.reverse_each.with_index do |a, i|
  sum += a
  sums[ais.size - i - 1] = sum
end

ans = 0_i64
max = 1_i64
ais.each_with_index do |a, i|
  max -= a
  if max < 0
    p -1
    exit
  end
  if i == ais.size - 1
    ans += a
  else
    ans += min(sums[i + 1], max) + a
  end
  if max < 1_000_000_000_000_000_000_i64
    max *= 2
  end
end
p ans
