require "big"

gets
ais = read_line.split.map(&.to_i64)
ans = 1_i64.to_big_i
if ais.any?(0)
  p 0
  exit
end
ais.each do |a|
  ans *= a
  if ans > 1_000_000_000_000_000_000_i64
    p -1
    exit
  end
end
p ans
