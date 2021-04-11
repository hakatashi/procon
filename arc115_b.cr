n = read_line.to_i64
css = [] of Array(Int64)
n.times do
  cs = read_line.split.map(&.to_i64)
  css << cs
end

min = css.map(&.min).min
ok = true
css.each_with_index do |cs, y|
  next if y == 0
  cs.each_cons(2).with_index do |(c1, c2), x|
    if c1 - c2 != css[0][x] - css[0][x + 1]
      ok = false
      next
    end
  end
  break unless ok
end
css.each_with_index do |cs, y|
  next if y == 0
  cs.each_with_index do |c, x|
    next if x == 0
    if c - css[y - 1][x] != css[y][0] - css[y - 1][0]
      ok = false
      next
    end
  end
  break unless ok
end
unless ok
  puts "No"
  exit
end

a_base = css[0].min
ais = [] of Int64
css.each do |cs|
  ais << cs[0] - (css[0][0] - a_base)
end

bs = [] of Int64
css[0].each do |c|
  bs << c - a_base
end

puts "Yes"
puts ais.join(' ')
puts bs.join(' ')
