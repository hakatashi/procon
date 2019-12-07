# -*- contest: sumitrust2019 -*-

n = read_line.to_i
1.upto(50000) do |i|
  if (i.to_f * 1.08).floor == n
    p i
    exit
  end
end
puts ":("