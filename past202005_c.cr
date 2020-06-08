# -*- contest: past202005-open -*-

a, r, n = read_line.split.map(&.to_i64)
if r == 1
  p a
  exit
end

ret = a
(n - 1).times do
  ret *= r
  if ret > 1_000_000_000_i64
    puts "large"
    exit
  end
end
p ret
