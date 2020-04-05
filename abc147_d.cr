def pow(b, e)
  mod = 1000000007_i64
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
ais = read_line.split.map(&.to_i64)
ans = 0_i64
60.times do |i|
  bits = ais.map {|a| (a >> i) & 1} .sum
  ret = (bits.as(Int64) * (ais.size - bits.as(Int64))) % 1000000007_i64
  ret = (ret * pow(2_i64, i)) % 1000000007_i64
  ans = (ans + ret) % 1000000007_i64
end
p ans