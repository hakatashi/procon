n = read_line.to_i64

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

factors = factorize(n)
factors2 = factorize(n - 1)
ans = 0_i64

f = factors.to_a.map { |(m, n)| (0..n).map { |i| m ** i } }
Array.each_product(f) do |pr|
  v = pr.reduce { |a, b| a * b }
  next if v == 1
  cn = n
  while cn % v == 0
    cn = cn // v
  end
  if cn % v == 1
    ans += 1
  end
end

if n > 2
  ans += factors2.values.map { |i| i + 1 }.reduce { |a, b| a * b } - 1
end
p ans
