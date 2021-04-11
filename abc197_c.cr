n = read_line.to_i64
ais = read_line.split.map(&.to_i64)

ans = 1_000_000_000_000_000_000_i64
1_i64.upto(n) do |i|
  (0_i64...n).to_a.each_combination(i) do |comb|
    vs = comb.to_set
    ret = 0_i64
    chunk = 0_i64
    ais.each_with_index do |a, j|
      chunk |= a
      if vs.includes?(j.to_i64)
        ret ^= chunk
        chunk = 0_i64
      end
    end
    ret ^= chunk
    if ret < ans
      ans = ret
    end
  end
end
p ans