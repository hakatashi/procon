t = gets.to_i
t.times do
  n = gets.to_i - 1
  a = (n / 3) * (n / 3 + 1) / 2 * 3
  b = (n / 5) * (n / 5 + 1) / 2 * 5
  c = (n / 15) * (n / 15 + 1) / 2 * 15
  puts a + b - c
end