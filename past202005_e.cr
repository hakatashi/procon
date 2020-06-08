# -*- contest: past202005-open -*-

n, m, q = read_line.split.map(&.to_i64)
pres = Array(Array(Int64)).new(n) { [] of Int64 }
m.times do
  u, v = read_line.split.map(&.to_i64)
  pres[u - 1] << v - 1
  pres[v - 1] << u - 1
end
cs = read_line.split.map(&.to_i64)
q.times do
  tokens = read_line.split.map(&.to_i64)
  if tokens[0] == 1
    _, x = tokens
    p cs[x - 1]
    pres[x - 1].each do |pre|
      cs[pre] = cs[x - 1]
    end
  else
    _, x, y = tokens
    p cs[x - 1]
    cs[x - 1] = y
  end
end
