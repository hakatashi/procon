# -*- contest: past202005-open -*-

n, m = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64)
states = Array(Int64).new(n, 0_i64)
ais.each do |a|
  i = states.bsearch_index { |state| state < a }
  if i.nil?
    p -1
  else
    p i + 1
    states[i] = a
  end
end
