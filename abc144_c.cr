n = read_line.to_u64
ret = 1_u64.upto(Math.sqrt(n).floor).min_by do |ri|
  i = ri.to_u64
  if n % i == 0
    ri + n // ri
  else
    n * 2
  end
end
p ret + n // ret - 2_u64