n_r, x = read_line.split
n = n_r.to_u64

2.upto(10) do |i|
  if x == n.to_s i
    puts i
  end
end
