n = read_line.to_i
songs = [] of Tuple(String, Int64)
n.times do
  s, rt = read_line.split
  t = rt.to_i64
  songs << {s, t}
end
x = read_line
asleep = false
ans = 0_i64
songs.each do |(s, t)|
  if asleep
    ans += t
  end
  asleep = true if s == x
end
p ans