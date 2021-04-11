require "big"

def min(a, b)
  a > b ? b : a
end
def max(a, b)
  a < b ? b : a
end

x = read_line
m = read_line.to_i64

if x.size == 1
  if x.to_i > m
    p 0
  else
    p 1
  end
  exit
end

d = x.chars.map(&.to_i64).max

if x.size == 2
  a, b = x.chars.map(&.to_i64)
  mx = (m - b) // a
  p max(0, mx - d)
  exit
end

ans = (d..m).bsearch do |i|
  big_i = i.to_big_i
  sum = BigInt.new(0)
  x.chars.reverse.each_with_index do |c, i|
    sum += c.to_i.to_big_i * big_i ** i
  end
  sum > m
end

if ans.nil?
  p 0
else
  p max((ans - 1) - d, 0)
end

