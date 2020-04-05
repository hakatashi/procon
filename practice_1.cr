# -*- contest: language-test-202001 -*-

sum = [read_line, read_line].map(&.split).flatten.map(&.to_i).sum
text = gets
puts "#{sum} #{text}"
