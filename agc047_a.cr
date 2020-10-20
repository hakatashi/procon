def min(a, b)
  a > b ? b : a
end

n = read_line.to_i64
imos = Array(Array(Int64)).new(19) { Array(Int64).new(19, 0_i64) }
queries = Array(Tuple(Int64, Int64)).new
n.times do
  ais = read_line.split('.')
  if ais.size == 1
    a = ais.first.to_i64 * 1_000_000_000_i64
  else
    a1, a2 = ais
    a = a1.to_i64 * 1_000_000_000_i64 + a2.ljust(9, '0').to_i64
  end
  twos = 0_i64
  until a % 2 != 0
    a //= 2
    twos += 1
  end
  fives = 0_i64
  until a % 5 != 0
    a //= 5
    fives += 1
  end
  y, x = min(twos, 18_i64), min(fives, 18_i64)
  imos[y][x] += 1
  queries << {x, y}
end
18_i64.downto(0_i64) do |y|
  18_i64.downto(0_i64) do |x|
    if y + 1 <= 18
      imos[y][x] += imos[y + 1][x]
    end
    if x + 1 <= 18
      imos[y][x] += imos[y][x + 1]
    end
    if x + 1 <= 18 && y + 1 <= 18
      imos[y][x] -= imos[y + 1][x + 1]
    end
  end
end
ans = 0_i64
queries.each do |query|
  x, y = query
  rx, ry = 18_i64 - x, 18_i64 - y
  ans += imos[ry][rx]
  if rx <= x && ry <= y
    ans -= 1
  end
end
p ans // 2
