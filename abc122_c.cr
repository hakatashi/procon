n, q = read_line.split.map(&.to_i)
a = Array(Int32).new(n, 0)
read_line.chars.each_cons(2).each_with_index do |con, i|
  if con == ['A', 'C']
    a[i + 1] = a[i] + 1
  else
    a[i + 1] = a[i]
  end
end
q.times do
  l, r = read_line.split.map(&.to_i)
  p a[r - 1] - a[l - 1]
end
