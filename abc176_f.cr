n = read_line.to_i64
ais = read_line.split.map {|a| a.to_i64 - 1 }
dp0 = Array(Int64).new(n, 0_i64)
dp1 = Array(Array(Int64)).new(n) { Array(Int64).new(n, -1_i64) }
dp2 = Array(Hash(Tuple(Int64, Int64), Int64)).new(n) { Hash(Tuple(Int64, Int64), Int64).new(-1_i64) }
chunks = (0...(n - 1)).to_a.map do |i|
  if i == 0
    ais[0...5]
  else
    ais[(i * 3 + 2)...(i * 3 + 5)]
  end
end
chunks.each_with_index do |chunk, i|
  # 0 => 0
  dp0[i + 1] = dp0[i]

  # 0 => 1
  chunk.uniq.each do |item|
    if dp1[i + 1][item] < dp0[i]
      dp1[i + 1][item] = dp0[i]
    end
  end

  # 0 => 2
  chunk.each_combination(2) do |(a, b)|
    a, b = b, a if a > b
    if dp2[i + 1][{a, b}] < dp0[i]
      dp2[i + 1][{a, b}] = dp0[i]
    end
  end

  dp1[i].each_with_index do |d, j|
    next if d == -1
    brought = j.to_i64 + 1
    if chunk.count(brought) >= 2
      # 1 => 0
      if dp0[i + 1] < d + 1
        dp0[i + 1] = d + 1
      end

      # 1 => 1
      chunk.uniq.each do |item|
        if dp1[i + 1][item] < d + 1
          dp1[i + 1][item] = d + 1
        end
      end

      # 1 => 2
      chunk.each_combination(2) do |(a, b)|
        a, b = b, a if a > b
        if dp2[i + 1][{a, b}] < d + 1
          dp2[i + 1][{a, b}] = d + 1
        end
      end
    else
      # 1 => 1
      if dp1[i + 1][brought] < d
        dp1[i + 1][brought] = d
      end

      # 1 => 2
      chunk.uniq.each do |item|
        if brought < item
          a, b = brought, item
        else
          a, b = item, brought
        end
        if dp2[i + 1][{a, b}] < d
          dp2[i + 1][{a, b}] = d
        end
      end
    end
  end

  dp2[i].each do |items, d|
    a, b = items
    if a == b && chunk.count(a) >= 1
      # 2 => 0
      if dp0[i + 1] < d + 1
        dp0[i + 1] = d + 1
      end

      # 2 => 1
      chunk.uniq.each do |item|
        if dp1[i + 1][item] < d + 1
          dp1[i + 1][item] = d + 1
        end
      end

      # 2 => 2
      chunk.each_combination(2) do |(a, b)|
        a, b = b, a if a > b
        if dp2[i + 1][{a, b}] < d + 1
          dp2[i + 1][{a, b}] = d + 1
        end
      end
    elsif chunk.count(a) >= 2
      # 2 => 1
      if dp1[i + 1][b] < d + 1
        dp1[i + 1][b] = d + 1
      end

      # 2 => 2
      chunk.uniq.each do |item|
        if b < item
          c, d = b, item
        else
          c, d = item, b
        end
        if dp2[i + 1][{c, d}] < d + 1
          dp2[i + 1][{c, d}] = d + 1
        end
      end
    elsif chunk.count(b) >= 2
      # 2 => 1
      if dp1[i + 1][a] < d + 1
        dp1[i + 1][a] = d + 1
      end

      # 2 => 2
      chunk.uniq.each do |item|
        if a < item
          c, d = a, item
        else
          c, d = item, a
        end
        if dp2[i + 1][{c, d}] < d + 1
          dp2[i + 1][{c, d}] = d + 1
        end
      end
    else
      # 2 => 2
      if dp2[i + 1][{a, b}] < d
        dp2[i + 1][{a, b}] = d
      end
    end
  end
end
p [dp0[n - 1], dp1[n - 1].max, dp2[n - 1].values.max].max
