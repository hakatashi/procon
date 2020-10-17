def max(a, b)
  a > b ? a : b
end


n = read_line.to_i64
cities = [] of Tuple(Int64, Int64, Int64)
n.times do
  x, y, z = read_line.split.map(&.to_i64)
  cities << {x, y, z}
end

INF = 1_000_000_000_000_000_000_i64

dp = Hash(Tuple(Int64, Int64), Int64).new(INF)
dp[{1_i64, 0_i64}] = 0_i64
tour = (1_i64...(1_i64 << n)).to_a
tour.sort_by!(&.popcount)
tour.each do |d|
  if d.popcount == n
    ans = INF
    n.times do |i|
      next if i == 0
      x, y, z = cities[i]
      nx, ny, nz = cities[0]
      cost = dp[{d, i}]
      new_cost = cost + (x - nx).abs + (y - ny).abs + max(0, nz - z)
      if ans > new_cost
        ans = new_cost
      end
    end
    p ans
    exit
  end

  n.times do |i|
    next unless dp.has_key?({d, i})
    x, y, z = cities[i]
    cost = dp[{d, i}]

    n.times do |j|
      next if (d >> j) & 1 == 1
      nx, ny, nz = cities[j]
      current_cost = dp[{d | (1 << j), j}]
      new_cost = cost + (x - nx).abs + (y - ny).abs + max(0, nz - z)
      if current_cost > new_cost
        dp[{d | (1 << j), j}] = new_cost
      end
    end
  end
end

