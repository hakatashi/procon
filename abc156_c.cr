gets
xs = read_line.split.map(&.to_i64)
ans = 1_000_000_000_000_i64
1.upto(100) do |c|
  ret = 0_i64
  xs.each do |x|
    ret += (x - c) ** 2
  end
  ans = [ans, ret].min
end
p ans
