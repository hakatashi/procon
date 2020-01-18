n = read_line.to_i64
robots = [] of Tuple(Int64, Int64)
n.times do
  x, l = read_line.split.map(&.to_i64)
  robots << {x - l, x + l}
end
robots.sort_by! {|(a, b)| a}
ans = 0_i64
cur_right = -10_000_000_000_i64
robots.each do |(left, right)|
  if cur_right <= left
    ans += 1
    cur_right = right
  end
  if right < cur_right
    cur_right = right
  end
end
p ans