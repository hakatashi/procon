n = read_line.to_i64

ans = 0_i64

1.upto(6) do |i|
  if n >= 10_i64 ** (i * 2) - 1
    ans += 10_i64 ** i - 10_i64 ** (i - 1)
  else
    a = n.to_s.rjust(i * 2, '0')[...i]
    b = n.to_s.rjust(i * 2, '0')[i...]
    if a.to_i > b.to_i
      ans += [a.to_i - 10_i64 ** (i - 1), 0].max
    else
      ans += [a.to_i - 10_i64 ** (i - 1) + 1, 0].max
    end
  end
end

p ans
