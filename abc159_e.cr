h, w, k = read_line.split.map(&.to_i64)
cells = [] of Array(Bool)
h.times do
  cells << read_line.chars.map {|c| c == '1'}
end
ans = 999_999_999_999_i64
(2_i64 ** (h - 1)).times do |pattern|
  impossible = false
  ret = pattern.popcount.to_i64
  pat = pattern.to_s(2).rjust(h - 1, '0').chars.map {|c| c == '1'}
  groups = Hash(Int64, Int64).new
  groups[0_i64] = 0_i64
  ptr = 0_i64
  pat.each_with_index do |patv, i|
    if patv == true
      ptr += 1
    end
    groups[i.to_i64 + 1] = ptr
  end
  group_counts = Hash(Int64, Int64).new(0_i64)
  w.times do |x|
    new_counts = Hash(Int64, Int64).new(0_i64)
    h.times do |y|
      if cells[y][x] == true
        new_counts[groups[y]] += 1
      end
    end
    new_counts.each do |g, c|
      if c > k
        impossible = true
        break
      end
      if group_counts[g] + c > k
        group_counts = Hash(Int64, Int64).new(0_i64)
        ret += 1
        break
      end
    end
    if impossible
      break
    end
    h.times do |y|
      if cells[y][x] == true
        group_counts[groups[y]] += 1
      end
    end
  end
  if !impossible && ret < ans
    ans = ret
  end
end
p ans

