gets
ps = read_line.split.map(&.to_i)
qs = read_line.split.map(&.to_i)
pv, qv = [ps, qs].map do |vs|
  nums = (1..ps.size).to_a
  ret = 0
  vs.each_with_index do |v, i|
    next if i == ps.size - 1
    ret += nums.index(v).not_nil!
    nums.delete(v)
    ret = ret * (ps.size - i - 1)
  end
  ret
end
p (qv - pv).abs