def min(a, b)
  a > b ? b : a
end
q = read_line.to_i64
q.times do
  a, b, c, d = read_line.split.map(&.to_i64)
  if (a - c).abs > (b - d).abs
    a, b, c, d = b, a, d, c
  end
  ans = 0_i64
  big = 3_i64 ** 30
  small = 3_i64 ** 29
  while small > 0
    if (a - c).abs < small && a % big // small == 1 && c % big // small == 1 && (b + small) // big != (d + small) // big
      offsetx = min(a, c) // big * big
      ans = min(
        (offsetx + small * 2 - a) + (offsetx + small * 2 - c) + (d - b).abs,
        (a - offsetx - small + 1) + (c - offsetx - small + 1) + (d - b).abs,
      )
      break
    end
    big //= 3
    small //= 3
  end
  p ans == 0 ? (a - c).abs + (b - d).abs : ans
end