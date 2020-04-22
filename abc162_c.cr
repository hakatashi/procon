k = read_line.to_i64
ans = 0_i64
1_i64.upto(k) do |a|
  1_i64.upto(k) do |b|
    1_i64.upto(k) do |c|
      ans += a.gcd(b).gcd(c)
    end
  end
end
p ans