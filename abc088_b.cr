# -*- contest: language-test-202001 -*-

gets
ais = read_line.split.map(&.to_i64).sort!.reverse!
p ais.each.with_index.sum { |(a, i)| a * (-1) ** i }
