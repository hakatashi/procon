# -*- contest: sumitrust2019 -*-

gets
s = read_line
ones = Set(Int32).new
twos = Set(Int32).new
threes = Set(Int32).new
s.chars.each do |c|
  n = c.to_i
  twos.each_with_index do |a, i|
    threes << i * 10 + n
  end
  ones.each_with_index do |a, i|
    twos << i * 10 + n
  end
  ones << n
end
p threes.size