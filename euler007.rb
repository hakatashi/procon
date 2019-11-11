require 'prime'
primes = Prime.take(10000)
t = gets.to_i
t.times do
  n = gets.to_i
  p primes[n - 1]
end