gets
ls = read_line.split.map(&.to_i64)
ans = 0_i64
ls.each_combination(3) do |(i, j, k)|
  a = i != j && j != k && k != i
  b = i + j > k
  c = j + k > i
  d = k + i > j
  if a && b && c && d
    ans += 1
  end
end
p ans
