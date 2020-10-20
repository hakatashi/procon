MOD = 1000000007_i64

def pow(b, e)
  ret = 1_u64
  while e > 0
    if e % 2 == 1
      ret = (ret * b) % MOD
    end
    b = (b * b) % MOD
    e = e // 2
  end
  ret
end

gets
cs = read_line.split.map(&.to_i64).sort.reverse
ans = 0_i64
cs.each_with_index do |c, i|
  if cs.size == 1
    tmp = 1_i64
  else
    tmp = (pow(2_i64, cs.size - 2) * (i + 2)) % MOD
  end
  tmp = (tmp * c) % MOD
  ans = (ans + tmp) % MOD
end
p (ans * pow(2_i64, cs.size)) % MOD
