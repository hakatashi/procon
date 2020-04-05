def pow(b, e)
  mod = 998244353_u64
  ret = 1_u64
  while e > 0
    if e % 2 == 1
      ret = (ret * b) % mod
    end
    b = (b * b) % mod
    e = e // 2
  end
  ret
end

gets
ds = read_line.split.map(&.to_u64)
if ds[0] != 0 || ds.count(0) != 1
  p 0
  exit
end
if ds.size == 1
  p 1
  exit
end
counts = Hash(UInt64, UInt64).new(0_u64, nil)
ds.each {|d| counts[d] += 1}
ret = 1_u64
(0..ds.max).each_cons(2) do |(a, b)|
  ret = (ret * pow(counts[a]? || 0_u64, counts[b]? || 0_u64)) % 998244353_u64
end
p ret