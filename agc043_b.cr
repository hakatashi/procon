require "set"

gets
ais = read_line.chars.map(&.to_i)
flag = false
if ais.uniq.to_set == Set{1, 3}
  flag = true
  ais.map! {|a| a == 1 ? 0 : 1}
else
  ais.map! {|a| a % 2}
end

def combination(n, r)
  n == (r | (n - r))
end

ans = false
ais.each_with_index do |a, i|
  ans = !ans if combination(ais.size - 1, i) && a == 1
end

if ans == true && flag == true
  p 2
else
  p ans ? 1 : 0
end