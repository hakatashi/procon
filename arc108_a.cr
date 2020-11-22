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


s, rp = read_line.split.map(&.to_i64)
factors = factorize(rp)
f = factors.to_a.map { |(m, n)| (0_i64..n).map { |i| m ** i } }
if f.empty?
  f = [[1_i64]]
end
Array.each_product(f) do |pr|
  factor = pr.reduce { |a, b| a * b }
  if rp // factor + factor == s
    puts "Yes"
    exit
  end
end
puts "No"