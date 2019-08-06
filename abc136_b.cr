n = read_line.to_i64
p (n - 9999).clamp(0, 90000) + (n - 99).clamp(0, 900) + n.clamp(0, 9)
