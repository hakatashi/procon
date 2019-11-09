n = read_line.to_i
if n <= 3
  p 0
elsif n % 2 == 0
  p n / 2 - 1
else
  p n / 2
end