h = read_line.to_i64
mul = 1_i64
ans = 0_i64
until h == 1
  ans += mul
  mul *= 2
  h //= 2
end
p ans + mul
