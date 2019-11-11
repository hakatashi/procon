require 'prime'
primes = Prime.take(100000)
prime_sums = [0]
primes.each do |prime|
  prime_sums << prime_sums.last + prime
end
t = gets.to_i
t.times do
  n = gets.to_i
  index = primes.bsearch_index {|v| v > n}
  p prime_sums[index]
end