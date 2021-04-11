h, w, a, b = read_line.split.map(&.to_i64)
ans = 0_i64
(0_i64...(h * w)).to_a.each_combination(a) do |comb|
  comb_set_original = 0_i64
  comb.each do |j|
    comb_set_original |= 1 << j
  end
  0_i64.to(a) do |i|
    comb.each_combination(i) do |vert|
      comb_set = comb_set_original
      vert_set = 0_i64
      vert.each do |j|
        vert_set |= 1 << j
      end
      ok = true
      comb.each do |tatami|
        y, x = tatami.divmod(w)
        if vert_set & (1 << tatami) != 0
          unless y != h - 1 && comb_set & (1 << ((y + 1) * w + x)) == 0
            ok = false
            break
          else
            comb_set |= 1 << ((y + 1) * w + x)
          end
        else
          unless x != w - 1 && comb_set & (1 << (y * w + x + 1)) == 0
            ok = false
            break
          else
            comb_set |= 1 << (y * w + x + 1)
          end
        end
      end
      if ok
        ans += 1
      end
    end
  end
end

p ans
