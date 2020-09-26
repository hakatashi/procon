def max(a, b)
  a > b ? a : b
end
def max(a, b, c)
  max(a, max(b, c))
end
def max(a, b, c, d)
  max(a, max(b, max(c, d)))
end
def max(a, b, c, d, e)
  max(a, max(b, max(c, max(d, e))))
end

r, c, k = read_line.split.map(&.to_i64)
items = Array(Array(Int64)).new(r) { Array(Int64).new(c, 0_i64) }
k.times do
  r0, c0, v = read_line.split.map(&.to_i64)
  items[r0 - 1][c0 - 1] = v
end
dp = {
  Array(Array(Int64)).new(4) { Array(Int64).new(c, 0_i64) },
  Array(Array(Int64)).new(4) { Array(Int64).new(c, 0_i64) },
}

r.times do |y|
  prev_dp = dp[(y - 1) % 2]
  now_dp = dp[y % 2]
  c.times do |x|
    4.times do |i|
      if x == 0 && y == 0
        if i != 0
          now_dp[i][x] = items[y][x]
        end
      end
      if i == 0
        if y != 0
          if x != 0
            now_dp[i][x] = max(
              prev_dp[0][x],
              prev_dp[1][x],
              prev_dp[2][x],
              prev_dp[3][x],
              now_dp[0][x - 1],
            )
          else
            now_dp[i][x] = max(
              prev_dp[0][x],
              prev_dp[1][x],
              prev_dp[2][x],
              prev_dp[3][x],
            )
          end
        end
      else
        if x != 0
          if i == 1
            now_dp[i][x] = max(
              now_dp[i][x - 1],
              now_dp[i - 1][x] + items[y][x],
            )
          else
            now_dp[i][x] = max(
              now_dp[i][x - 1],
              now_dp[i - 1][x - 1] + items[y][x],
            )
          end
        else
          if i == 1
            now_dp[i][x] = now_dp[i - 1][x] + items[y][x]
          end
        end
      end
    end
  end
end

p max(
  dp[(r - 1) % 2][0][c - 1],
  dp[(r - 1) % 2][1][c - 1],
  dp[(r - 1) % 2][2][c - 1],
  dp[(r - 1) % 2][3][c - 1],
)