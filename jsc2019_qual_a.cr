mm, dd = read_line.split.map(&.to_i)
ret = 0
mm.times do |m|
  dd.times do |d|
    d1 = (d + 1) % 10
    d2 = (d + 1) // 10
    ret += 1 if d1 >= 2 && d2 >= 2 && d1 * d2 == m + 1
  end
end
puts ret