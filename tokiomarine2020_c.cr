def min(a, b)
  a > b ? b : a
end

def max(a, b)
  a < b ? b : a
end

def clamp(a, b, c)
  max(a, min(b, c))
end

n, k = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)

[k, 1000].min.times do
  imos = Array(Int64).new(n + 1, 0_i64)
  ais.each_with_index do |a, i|
    imos[clamp(0, i - a, n)] += 1
    imos[clamp(0, i + a + 1, n)] -= 1
  end
  r = 0_i64
  n.times do |i|
    r += imos[i]
    ais[i] = r
  end
end
puts ais.join(' ')
