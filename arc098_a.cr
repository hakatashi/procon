gets
cs = read_line.chars
counts_east = Array(UInt64).new(cs.size + 1, 0)
cs.each_with_index do |c, i|
  counts_east[i + 1] = counts_east[i] + (c == 'W' ? 1 : 0)
end
counts_west = Array(UInt64).new(cs.size + 1, 0)
cs.reverse.each_with_index do |c, i|
  counts_west[cs.size - i - 2] = counts_west[cs.size - i - 1] + (c == 'E' ? 1 : 0)
end
a, b = counts_east.zip(counts_west).min_by {|a, b| a + b}
p a + b
