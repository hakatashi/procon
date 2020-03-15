a, b, c = read_line.split.map(&.to_i64)
puts (c - a - b >= 0 && 4_i64 * a * b < (c - a - b) ** 2) ? "Yes" : "No"