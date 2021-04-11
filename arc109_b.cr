n = read_line.to_i64
ans = (0_i64..Int32::MAX.to_i64).bsearch do |i|
  i * (i + 1) // 2 > n + 1
end.not_nil! - 1
p n + 1 - ans