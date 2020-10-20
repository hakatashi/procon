def is_prime(n)
  i = 2
  until i * i > n
    if n % i == 0
      return false
    end
    i += 1
  end
  true
end

x = read_line.to_i
x.upto(x + 10000) do |k|
  if is_prime(k)
    p k
    exit
  end
end
