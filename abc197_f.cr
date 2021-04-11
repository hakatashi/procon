n, m = read_line.split.map(&.to_i64)
pres = Array(Array({Int64, Char})).new(n) { [] of {Int64, Char} }
dp = Array(Array(Int64)).new(n) { Array(Int64).new(n, -1_i64) }
queue = Deque({Int64, Int64, Int64}).new
n.times do |i|
  dp[i][i] = 0_i64
  queue << {i, i, 0_i64}
end
m.times do
  ra, rb, rc = read_line.split
  a = ra.to_i64
  b = rb.to_i64
  c = rc[0]
  pres[a - 1] << {b - 1, c}
  pres[b - 1] << {a - 1, c}
  dp[a - 1][b - 1] = 1_i64
  dp[b - 1][a - 1] = 1_i64
  queue << {a - 1, b - 1, 1_i64}
  if a - 1 == 0 && b - 1 == n - 1
    p 1
    exit
  end
end

until queue.empty?
  a, b, size = queue.shift

  pres[a].each do |(pre_a, letter_a)|
    pres[b].each do |(pre_b, letter_b)|
      if letter_a == letter_b
        if dp[pre_a][pre_b] == -1
          dp[pre_a][pre_b] = size + 2
          dp[pre_b][pre_a] = size + 2
          queue << {pre_a, pre_b, size + 2}
          if (pre_a == 0 && pre_b == n - 1) || (pre_b == 0 && pre_a == n - 1)
            p size + 2
            exit
          end
        end
      end
    end
  end
end

p -1
