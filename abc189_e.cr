n = read_line.to_i64
pieces = Array(Tuple(Int64, Int64)).new(n)
n.times do
  x, y = read_line.split.map(&.to_i64)
  pieces << {x, y}
end
m = read_line.to_i64
matrices = Array(Tuple(Int64, Int64, Int64, Int64, Int64, Int64)).new(m + 1)
matrix = {1_i64, 0_i64, 0_i64, 1_i64, 0_i64, 0_i64}
matrices << matrix
m.times do
  op = read_line.split.map(&.to_i64)
  a, b, c, d, e, f = matrix
  if op[0] == 1
    matrix = {b, -a, d, -c, f, -e}
  elsif op[0] == 2
    matrix = {-b, a, -d, c, -f, e}
  elsif op[0] == 3
    matrix = {-a, b, -c, d, op[1] * 2 - e, f}
  else
    matrix = {a, -b, c, -d, e, op[1] * 2 - f}
  end
  matrices << matrix
end
q = read_line.to_i64
q.times do |i|
  a, b = read_line.split.map(&.to_i64)
  ma, mb, mc, md, me, mf = matrices[a]
  x, y = pieces[b - 1]
  puts "#{x * ma + y * mc + me} #{x * mb + y * md + mf}"
end
