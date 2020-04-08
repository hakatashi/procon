# -*- contest: language-test-202001 -*-

a, b = read_line.split.map(&.to_i64)
puts a * b % 2 == 0 ? "Even" : "Odd"
