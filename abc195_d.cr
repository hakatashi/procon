n, m, q = read_line.split.map(&.to_i64)
cargos = [] of {Int64, Int64}
n.times do
  w, v = read_line.split.map(&.to_i64)
  cargos << {w, v}
end
cargos.sort_by! {|(w, v)| w}
xs = read_line.split.map(&.to_i64)
queries = [] of {Int64, Int64}
q.times do
  l, r = read_line.split.map(&.to_i64)
  queries << {l - 1, r - 1}
end

queries.each do |(l, r)|
  boxes = [] of Int64
  xs.each_with_index do |x, i|
    if i < l || r < i
      boxes << x
    end
  end
  boxes.sort!

  ans = 0_i64
  new_cargos = cargos.clone
  boxes.each do |box|
    max_cargo = new_cargos.bsearch_index {|(w, v)| w > box}
    if max_cargo.nil?
      max_cargo = new_cargos.size
    end
    max = 0_i64
    max_index = -1
    new_cargos[0...max_cargo].each_with_index do |(w, v), i|
      if v > max
        max = v
        max_index = i
      end
    end
    if max_index != -1
      ans += max
      new_cargos[max_index] = {new_cargos[max_index][0], 0_i64}
    end
  end
  p ans
end
