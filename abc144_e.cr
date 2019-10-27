n, k = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64).sort.reverse
fs = read_line.split.map(&.to_i64).sort
ret = (0_i64..(ais.max * fs.max)).bsearch do |x|
  costs = fs.zip(ais).sum {|(f, a)| a < x / f ? 0_i64 : (a - x / f) }
  costs <= k
end
p ret
