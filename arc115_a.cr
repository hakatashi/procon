n, m = read_line.split.map(&.to_i64)
ss = [] of Int64
n.times do
  s = read_line.to_i64(2)
  ss << s
end
odds = 0_i64
evens = 0_i64

ss.each do |s|
  if s.popcount.even?
    evens += 1
  else
    odds += 1
  end
end

p evens * odds
