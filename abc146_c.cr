a, b, x = read_line.split.map(&.to_i64)
10_i64.downto(1_i64) do |i|
  next if x - i * b <= 0
  n = (x - i * b) // a
  if 10_i64 ** (i - 1) <= n
    p [n, 10_i64 ** i - 1, 10_i64 ** 9].min
    exit
  end
end
p 0
