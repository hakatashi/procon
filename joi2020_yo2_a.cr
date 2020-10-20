# -*- contest: joi2020yo2 -*-

n = read_line.to_i
sss = [] of Array(Char)
tss = [] of Array(Char)
n.times do
  sss << read_line.chars
end
n.times do
  tss << read_line.chars
end
ans = 1000000
[0, 1, 2, 1].each do |k|
  ret = k
  n.times do |i|
    n.times do |j|
      ret += 1 if sss[i][j] != tss[i][j]
    end
  end
  ans = [ans, ret].min
  new_sss = [] of Array(Char)
  n.times do |i|
    ss = [] of Char
    n.times do |j|
      ss << sss[n - j - 1][i]
    end
    new_sss << ss
  end
  sss = new_sss
end
p ans
