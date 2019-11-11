require 'prime'
n = 0
answers = []
(1..).each do |i|
  n += i
  factors = if n == 1
    1
  else
    n.prime_division.map {|d| d[1] + 1} .inject(:*)
  end
  until answers.size >= factors
    answers << n
  end
  break if factors >= 1e3
end
t = gets.to_i
t.times do
  n = gets.to_i
  p answers[n]
end