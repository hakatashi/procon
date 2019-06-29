gets
cs = read_line.split(" ").map(&.to_i)
count = 0
cs.each_cons(3) do |con|
  a, b, c = con
  if a < b < c || a > b > c
    count += 1
  end
end
puts count
