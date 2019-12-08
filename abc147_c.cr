n = read_line.to_i
xss = [] of Array(Tuple(Int32, Int32))
n.times do
  xs = [] of Tuple(Int32, Int32)
  a = read_line.to_i
  a.times do
    x, y = read_line.split.map(&.to_i)
    xs << {x, y}
  end
  xss << xs
end
ret = 0
(2 ** n).times do |i|
  fs = [] of Int32
  n.times do |j|
    fs << ((i >> j) & 1)
  end
  ans = 0
  fail = 0
  n.times do |j|
    f = fs[j]
    xs = xss[j]
    if f == 1
      if xs.all? {|(x, y)| fs[x - 1] == y}
        ans += 1
      else
        fail = 1
      end
    end
  end
  unless fail == 1
    ret = [ret, ans].max
  end
end
p ret