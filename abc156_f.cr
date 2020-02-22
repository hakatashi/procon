k, q = read_line.split.map(&.to_i64)
ds = read_line.split.map(&.to_i64)
q.times do
  n, x, m = read_line.split.map(&.to_i64)
  a = x % m
  cnt = 0_i64
  ds.each_with_index do |d, i|
    next if d % m == 0
    if i < (n - 1) % ds.size
      mul = (n - 1) / ds.size + 1
    else
      mul = (n - 1) / ds.size
    end
    a += (d % m) * mul
    cnt += mul
  end
  p cnt - a / m
end