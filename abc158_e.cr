def pow(b, e, m)
  ret = 1_u64
  while e > 0
    if e % 2 == 1
      ret = (ret * b) % m
    end
    b = (b * b) % m
    e = e / 2
  end
  ret
end

n, pv = read_line.split.map(&.to_i64)
s = read_line
dp = Array(Int64).new(pv, 0_i64)

ans = 0_i64
if pv == 2 || pv == 5
  s.chars.each_with_index do |c, i|
    d = c.to_i64
    if d % pv == 0
      ans += i + 1
    end
  end
else
  ret = 0_i64
  counts = Hash(Int64, Int64).new(0_i64)
  s.chars.reverse_each.with_index do |c, i|
    d = c.to_i64
    counts[ret] += 1
    ret = (ret + d * pow(10, i + 1, pv)) % pv
    ans += counts[ret]
  end
end

p ans
