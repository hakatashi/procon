def min(a, b)
  a > b ? b : a
end

n, x, y = read_line.split.map(&.to_i64)
x -= 1
y -= 1
ans = Array(Int64).new(n + 1, 0_i64)
n.times do |i|
  (i + 1).upto(n - 1) do |j|
    dist = min((i - j).abs, min((i - x).abs + (j - y).abs + 1, (i - y).abs + (j - x).abs + 1))
    ans[dist] += 1
  end
end
1_i64.upto(n - 1) do |i|
  p ans[i]
end
