n, m = read_line.split.map(&.to_i64)
constraints = [] of Tuple(Int64, Int64)
m.times do
  s, c = read_line.split.map(&.to_i64)
  constraints << {s, c}
end
0.upto(999) do |i|
  is = i.to_s
  next if is.size != n
  ok = true
  constraints.each do |(s, c)|
    if is[s - 1].to_s != c.to_s
      ok = false
      break
    end
  end
  if ok
    p i
    exit
  end
end
p -1