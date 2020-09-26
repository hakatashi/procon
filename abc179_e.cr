n, x, m = read_line.split.map(&.to_i64)
h = Hash(Int64, Int64).new
ans = 0_i64
vals = Array(Int64).new(100_000_i64)
n.times do |i|
  if h.has_key?(x)
    span = i - h[x]
    partial_sum = vals[h[x]..].sum
    ans += partial_sum * ((n - i) // span)
    ans += vals[h[x]...(h[x] + (n - i) % span)].sum
    p ans
    exit
  else
    h[x] = i
    vals << x
    ans += x
  end
  x = (x * x) % m
end
p ans
