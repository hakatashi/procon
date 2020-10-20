def min(a, b)
  a > b ? b : a
end

h, w = read_line.split.map(&.to_i64)
map = [] of Array(Char)
h.times do
  map << read_line.chars
end
dp = Array(Array(Int64)).new(h) { Array(Int64).new(w, 0_i64) }
if map[0][0] == '#'
  dp[0][0] = 1_i64
end

h.times do |y|
  w.times do |x|
    next if x == 0 && y == 0

    c = map[y][x]
    hor = 99999_i64
    if x != 0
      if c == '#' && map[y][x - 1] == '.'
        hor = dp[y][x - 1] + 1
      else
        hor = dp[y][x - 1]
      end
    end

    vert = 99999_i64
    if y != 0
      if c == '#' && map[y - 1][x] == '.'
        vert = dp[y - 1][x] + 1
      else
        vert = dp[y - 1][x]
      end
    end

    dp[y][x] = min(hor, vert)
  end
end

p dp[h - 1][w - 1]
