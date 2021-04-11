n = read_line.to_i64
ais = read_line.split.map(&.to_i64) + [0_i64]
ans = 0_i64
stack = Deque(NamedTuple(value: Int64, index: Int64)).new
stack << {value: 0_i64, index: -1_i64}
ais.each_with_index do |a, i|
  popped_i = i.to_i64
  until stack.last[:value] <= a
    item = stack.pop
    popped_i = item[:index]
    res = item[:value] * (i - item[:index])
    if ans < res
      ans = res
    end
  end
  if stack.last[:value] != a
    stack << {value: a, index: popped_i}
  end
end
p ans
