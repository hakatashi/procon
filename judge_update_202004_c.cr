a1, a2, a3 = read_line.split.map(&.to_i64)
sum = a1 + a2 + a3

ans = 0
(1..sum).to_a.each_permutation do |perm|
  p1 = perm[0...a1]
  p2 = perm[a1...a1+a2]
  p3 = perm[a1+a2...perm.size]
  ps = [p1, p2, p3]

  ok = true
  ps.each do |subperm|
    subperm.each_cons(2) do |(a, b)|
      if a > b
        ok = false
        break
      end
    end
    break unless ok
  end
  next unless ok

  ps.each_cons(2) do |(ap, bp)|
    bp.each_with_index do |e, i|
      if i < ap.size && ap[i] > bp[i]
        ok = false
        break
      end
    end
    break unless ok
  end
  next unless ok

  ans += 1
end

p ans
