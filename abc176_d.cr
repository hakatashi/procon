h, w = read_line.split.map(&.to_i64)
ch, cw = read_line.split.map(&.to_i64)
dh, dw = read_line.split.map(&.to_i64)
sss = [] of Array(Char)
h.times do
  sss << read_line.chars
end
dists = Array(Array(Int64)).new(h) { Array(Int64).new(w, -1_i64) }
dist = 0_i64
queue = Deque(Tuple(Int64, Int64)).new
queue << {ch - 1, cw - 1}
loop do
  next_queue = Deque(Tuple(Int64, Int64)).new
  new_places = 0_i64
  until queue.empty?
    ph, pw = queue.shift
    next if sss[ph][pw] == '#'
    next if dists[ph][pw] != -1
    dists[ph][pw] = dist
    new_places += 1
    if ph == dh - 1 && pw == dw - 1
      p dist
      exit
    end
    if ph + 1 < h
      queue << {ph + 1, pw}
    end
    if ph - 1 >= 0
      queue << {ph - 1, pw}
    end
    if pw + 1 < w
      queue << {ph, pw + 1}
    end
    if pw - 1 >= 0
      queue << {ph, pw - 1}
    end
    (-2_i64).upto(2_i64) do |x|
      (-2_i64).upto(2_i64) do |y|
        next if x == 0 && -1 <= y && y <= 1
        next if y == 0 && -1 <= x && x <= 1
        if ph + y < h && ph + y >= 0 && pw + x < w && pw + x >= 0
          next_queue << {ph + y, pw + x}
        end
      end
    end
  end
  dist += 1
  queue = next_queue
  if new_places == 0
    p -1
    exit
  end
end
