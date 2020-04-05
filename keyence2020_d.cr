n = read_line.to_i64
ais = read_line.split.map(&.to_i64)
bs = read_line.split.map(&.to_i64)
cards = ais.zip(bs)
ans = -1_i64

[0, 1].each_repeated_permutation((n + 1) // 2) do |evens_perm|
  [0, 1].each_repeated_permutation(n // 2) do |odds_perm|
    next if evens_perm.sum != odds_perm.sum # parity
    odds = [] of Tuple(Int64, Int32)
    evens = [] of Tuple(Int64, Int32)
    cards.each_with_index do |(a, b), i|
      if i % 2 == 0
        if evens_perm[i // 2] == 0
          evens << {a, i}
        else
          odds << {b, i}
        end
      else
        if odds_perm[i // 2] == 0
          odds << {a, i}
        else
          evens << {b, i}
        end
      end
    end
    evens.sort!
    odds.sort!
    perm = [] of Tuple(Int64, Int32)
    n.times.all? do |i|
      if i % 2 == 0
        perm << evens[i // 2]
      else
        perm << odds[i // 2]
      end
    end
    ok = perm.each_cons(2).all? do |(a, b)|
      a[0] <= b[0]
    end
    next unless ok
    ret = 0_i64
    n.times do |i|
      i.upto(n - 1) do |j|
        if perm[i][1] > perm[j][1]
          perm[i], perm[j] = perm[j], perm[i]
          ret += 1
        end
      end
    end
    if ans == -1 || ret < ans
      ans = ret
    end
  end
end

p ans