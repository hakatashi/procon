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

def max(a, b)
  a < b ? b : a
end

n, q = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)
ss = read_line.split.map(&.to_i64)

prev_factors = Set(Int64).new
factorize(ais[0]).each do |factor, count|
  prev_factors << factor
end

factor_lens = Hash(Int64, Int64).new
ais.each_with_index do |a, i|
  prev_factors.each do |factor|
    unless a % factor == 0
      factor_lens[factor] = i.to_i64
      prev_factors.delete(factor)
    end
  end
end

prev_factors.each do |factor|
  factor_lens[factor] = ais.size.to_i64
end

gcd_all = ais.reduce {|a, b| a.gcd(b)}

ss.each do |s|
  gcd = s.gcd(gcd_all)
  if gcd != 1
    p gcd
  else
    factors = factorize(s)
    ans = 0_i64
    factors.each do |factor, count|
      if factor_lens.has_key?(factor)
        ans = max(ans, factor_lens[factor])
      end
    end
    p ans + 1
  end
end
