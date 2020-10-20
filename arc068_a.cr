n = read_line.to_u64
div, mod = n.divmod(11)
if mod == 0
  p div * 2
elsif mod <= 6
  p div * 2 + 1
else
  p div * 2 + 2
end
