fib = [1, 1]
until fib.last >= 4e16
  fib << fib[-2] + fib[-1]
end
t = gets.to_i
t.times do
  n = gets.to_i
  p fib.select {|v| v % 2 == 0 && v <= n}.sum
end