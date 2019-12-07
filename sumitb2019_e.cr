# -*- contest: sumitrust2019 -*-

gets
ais = read_line.split.map(&.to_i64)
counters = [0, 0, 0]
ret = 1_i64
ais.each do |a|
  ret = (ret * counters.count {|c| c == a}) % 1000000007
  i = counters.index(a)
  unless i.nil?
    counters[i] += 1
  end
end
p ret