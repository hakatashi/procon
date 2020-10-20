n, d, a = read_line.split.map(&.to_i64)
monsters = [] of Tuple(Int64, Int64)
n.times do
  x, h = read_line.split.map(&.to_i64)
  monsters << {x, h}
end
monsters.sort_by! { |(x, h)| x }
ans = 0_i64
resets = [] of Tuple(Int64, Int64)
damage = 0_i64

monsters.each_with_index do |(x, h), i|
  if h <= 0
    next
  end

  loop do
    break if resets.empty?
    x2, ev = resets.first.not_nil!
    if x <= x2
      break
    end
    resets.shift
    damage -= ev
  end

  next if damage >= h

  bomb = ((h - damage).to_f // a.to_f).ceil.to_i64
  ans += bomb
  damage += a * bomb
  resets << {x + d * 2, a * bomb}
end
p ans
