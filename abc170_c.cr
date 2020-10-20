require "set"

x, n = read_line.split.map(&.to_i64)
ps = read_line.split.map(&.to_i64).to_set

ans = (0_i64..101_i64).min_by do |i|
  if ps.includes?(i)
    1_000_000_i64
  else
    (x - i).abs
  end
end
p ans
