a1, a2, a3 = read_line.split.map(&.to_i64)
sum = a1 + a2 + a3

ans = (1..sum).to_a.each_permutation.count do |perm|
  ps = [
    perm[0...a1],
    perm[a1...a1 + a2],
    perm[a1 + a2...perm.size],
  ]

  next if false == ps.each do |subperm|
            break false if false == subperm.each_cons(2) do |(a, b)|
                             if a > b
                               break false
                             end
                           end
          end

  next if false == ps.each_cons(2) do |(ap, bp)|
            break false if false == bp.each_with_index do |e, i|
                             if i < ap.size && ap[i] > bp[i]
                               break false
                             end
                           end
          end

  true
end

p ans
