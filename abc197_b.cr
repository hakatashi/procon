def min(a, b)
  a > b ? b : a
end
def max(a, b)
  a < b ? b : a
end

h, w, cy, cx = read_line.split.map(&.to_i64)
sss = [] of Array(Char)
h.times do
  ss = read_line.chars
  sss << ss
end

ans = 0_i64
h.times do |y|
  w.times do |x|
    next if y != cy - 1 && x != cx - 1

    ok = true
    sy = min(y, cy - 1)
    ey = max(y, cy - 1)
    sx = min(x, cx - 1)
    ex = max(x, cx - 1)

    h.times do |ay|
      w.times do |ax|
        if sy <= ay && ay <= ey && sx <= ax && ax <= ex && sss[ay][ax] != '.'
          ok = false
          break
        end
      end 
    end

    if ok
      ans += 1
    end
  end
end
p ans
