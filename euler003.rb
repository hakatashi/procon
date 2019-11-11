t = gets.to_i
t.times do
  n = gets.to_i
  i = 2
  while i * i <= n
    if n % i == 0
      n = n / i
      next
    end
    i += 1
  end
  p n
end