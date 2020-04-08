# -*- contest: language-test-202001 -*-

n = read_line.to_i64
ds = [] of Int64
n.times do
  ds << read_line.to_i64
end
p ds.uniq.size
