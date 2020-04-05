# -*- contest: sumitrust2019 -*-

x = read_line.to_i
a = x // 100
b = x % 100
if b <= a * 5
  p 1
else
  p 0
end