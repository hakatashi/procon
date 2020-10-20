require "big"
h, w = read_line.split.map(&.to_i)
board = [] of Array(Int16)
h.times do
  board << read_line.split.map(&.to_i16)
end
h.times do |i|
  line = board[i]
  read_line.split.map(&.to_i16).each_with_index do |b, j|
    line[j] = (line[j] - b).abs
  end
end
dpss = [] of Array(BigInt)
h.times do |y|
  dps = [] of BigInt
  dpss << dps
  w.times do |x|
    dp = BigInt.new
    c = board[y][x]
    if x == 0 && y == 0
      dp |= 1.to_big_i << (c + 15000)
    else
      if x != 0
        dp |= (dpss[y][x - 1] << c) | (dpss[y][x - 1] >> c)
      end
      if y != 0
        dp |= (dpss[y - 1][x] << c) | (dpss[y - 1][x] >> c)
      end
    end
    dps << dp
  end
end
p (0..30000).select { |i| dpss[h - 1][w - 1].bit(i) == 1 }.min_of { |b| (15000 - b).abs }
