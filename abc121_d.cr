a, b = read_line.split.map(&.to_u64)
a, b = [a - 1, b].map do |n|
  (n % 2 == 0 ? n : 0_u64) ^ ((n + 1) // 2 % 2)
end
p a ^ b