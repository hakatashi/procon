# -*- contest: language-test-202001 -*-

sum = [read_line, read_line].map(&.split(/\s/)).flatten.map(&.to_i).sum
text = gets
puts "#{sum} #{text}"
