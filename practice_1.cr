# -*- status: skip -*-

sum = [read_line, read_line].map(&.split(/\s/)).flatten.map(&.to_i).sum
text = gets
puts "#{sum} #{text}"
