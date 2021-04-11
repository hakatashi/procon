def min(a, b)
  a > b ? b : a
end

h, w = read_line.split.map(&.to_i64)
map = [] of Array(Char)
h.times do
  cs = read_line
  map << cs.chars
end
dp = Array(Array(Int64)).new(h) { Array(Int64).new(w, 1_000_000_i64) }
dp[0][0] = 0_i64
h.times do |y|
  w.times do |x|
    if x > 0
      if map[y][x - 1] == 'E'
        dp[y][x] = min(dp[y][x], dp[y][x - 1])
      else
        dp[y][x] = min(dp[y][x], dp[y][x - 1] + 1)
      end
    end
    if y > 0
      if map[y - 1][x] == 'S'
        dp[y][x] = min(dp[y][x], dp[y - 1][x])
      else
        dp[y][x] = min(dp[y][x], dp[y - 1][x] + 1)
      end
    end
  end
end
if map[h - 1][w - 1] == 'E'
  p dp[h - 1][w - 1]
else
  p dp[h - 1][w - 1] + 1
end
