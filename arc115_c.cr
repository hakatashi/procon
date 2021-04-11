n = read_line.to_i64
ans = Array(Int64).new(n, 1_i64)
1_i64.upto(n) do |i|
  a = ans[i - 1]
  (i * 2).step(by: i, to: n) do |j|
    if ans[j - 1] <= a
      ans[j - 1] = a + 1
    end
  end
end
puts ans.join(' ')
