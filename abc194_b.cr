def max(a, b)
  a > b ? a : b
end


n = read_line.to_i64
ais = [] of Int64
bs = [] of Int64
n.times do
  a, b = read_line.split.map(&.to_i64)
  ais << a
  bs << b
end

ans = Int64::MAX
ais.each_with_index do |a, i|
  bs.each_with_index do |b, j|
    if i == j
      ret = a + b
    else
      ret = max(a, b)
    end
    if ret < ans
      ans = ret
    end
  end
end
p ans
