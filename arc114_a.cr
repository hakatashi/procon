gets
xs = read_line.split.map(&.to_i64)

ns = [2_i64, 3_i64, 5_i64, 7_i64, 11_i64, 13_i64, 17_i64, 19_i64, 23_i64, 29_i64, 31_i64, 37_i64, 41_i64, 43_i64, 47_i64]
ans = 1_000_000_000_000_000_000_i64
Array.each_product(ns.map {|n| [1_i64, n]}) do |prod|
  n = prod.reduce {|a, b| a * b}
  if ans > n && xs.all? {|x| x.gcd(n) != 1}
    ans = n
  end
end
p ans