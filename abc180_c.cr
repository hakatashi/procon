def factorize(n)
  i = 2_i64
  h = Hash(Int64, Int64).new(0_i64)
  until i * i > n
    if n % i == 0
      n = n // i
      h[i] += 1
    else
      i += 1
    end
  end
  if n > 1
    h[n] += 1
  end
  h
end

n = read_line.to_i64
if n == 1
  p 1
  exit
end
factors = factorize(n)
f = factors.to_a.map { |(m, n)| (0_i64..n).map { |i| m ** i } }
ans = [] of Int64
Array.each_product(f) do |pr|
  ans << pr.reduce { |a, b| a * b }
end
ans.sort!
ans.each do |a|
  p a
end
