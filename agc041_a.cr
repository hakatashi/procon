n, a, b = read_line.split.map(&.to_i64)
if (b - a) % 2 == 0
  p (b - a) // 2
  exit
end
p [(a + b - 1) // 2, (n - a + n - b + 1) // 2].min