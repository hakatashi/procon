n = read_line.to_i64
k = read_line.to_i64
ret = 0_u64
2_i64.upto(Math.sqrt(k).to_u64) do |i|
  if k % i == 0
    ret += [[i - 1, n].min - [1, i - n].max + 1, 0].max * [[k // i - 1, n].min - [1, k // i - n].max + 1, 0].max * 2
  end
end
puts ret