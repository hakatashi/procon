t = gets.to_i
t.times do
  n = gets.to_i
  p n * n * (n + 1) * (n + 1) / 4 - n * (n + 1) * (2 * n + 1) / 6
end