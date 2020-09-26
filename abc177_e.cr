def factorize(n)
  i = 2_i64
  until i * i > n
    if n % i == 0
      while n % i == 0
        n = n // i
      end
      yield(i)
    else
      i += 1
    end
  end
  if n > 1
    yield(n)
  end
end


gets
ais = read_line.split.map(&.to_i64)
lcm = Set(Int64).new
is_pairwise_coprime = true
ais.each do |a|
  factorize(a) do |factor|
    if lcm.includes?(factor)
      is_pairwise_coprime = false
    else
      lcm << factor
    end
  end
end
if is_pairwise_coprime
  puts "pairwise coprime"
elsif ais.reduce {|a, b| a.gcd(b)} == 1
  puts "setwise coprime"
else
  puts "not coprime"
end