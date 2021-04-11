def pow(b, e, mod)
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

a, b, c = read_line.split.map(&.to_i64)

seq = [] of Int64
seq << a % 10
until seq.includes?(seq.last * a % 10)
  seq << seq.last * a % 10
end
size = seq.size - seq.index(seq.last * a % 10).not_nil!

p seq[(pow(b, c, size).to_i64 - 1) % size]

