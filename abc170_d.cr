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
ais = read_line.split.map(&.to_i64)

ok = Array(Bool).new(n, true)

dp = Array(Bool).new(1_000_001_i64, false)
ais.each_with_index do |a, i|
  if a == 1
    if dp[1] == true
      ok[i] = false
    end
  else
    factors = factorize(a)
    f = factors.to_a.map {|(m, n)| (0_i64..n).map {|i| m ** i}}
    Array.each_product(f) do |pr|
      if dp[pr.reduce {|a, b| a * b}] == true
        ok[i] = false
        break
      end
    end
  end
  dp[a] = true
end

dp = Array(Bool).new(1_000_001_i64, false)
ais.reverse_each.with_index do |a, ri|
  i = n - ri - 1
  if a == 1
    if dp[1] == true
      ok[i] = false
    end
  else
    factors = factorize(a)
    f = factors.to_a.map {|(m, n)| (0_i64..n).map {|i| m ** i}}
    Array.each_product(f) do |pr|
      if dp[pr.reduce {|a, b| a * b}] == true
        ok[i] = false
        break
      end
    end
  end
  dp[a] = true
end

p ok.count(true)
