h, w, k = read_line.split.map(&.to_i64)
map = Array(Array(Char)).new
h.times do
  map << read_line.chars
end
ans = 0_i64
(1_i64 << h).times do |i|
  (1_i64 << w).times do |j|
    cnt = 0_i64
    h.times do |y|
      w.times do |x|
        if ((i >> y) & 1) == 0 && ((j >> x) & 1) == 0 && map[y][x] == '#'
          cnt += 1
        end
      end
    end
    if cnt == k
      ans += 1
    end
  end
end
p ans
