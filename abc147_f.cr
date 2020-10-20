n, x, d = read_line.split.map(&.to_i64)
if x == 0 && d == 0
  p 1
  exit
end
if d == 0
  p n + 1
  exit
end
if d < 0
  x = -x
  d = -d
end
if x == 0
  interval = 1_i64
else
  interval = [(x * 2).lcm(d * 2) // (x * 2).abs, n + 1].min
end
infoss = Array.new(interval) { [] of Tuple(Symbol, Int64) }
(n + 1).times do |i|
  a = n - i * 2
  b_max = n * (n - 1) // 2 - i * (i - 1)
  b_min = (n - i) * (n - i - 1) - n * (n - 1) // 2
  max = a * x + b_max * d
  min = a * x + b_min * d
  infoss[i % interval] << {:open, min}
  infoss[i % interval] << {:close, max}
end
ret = 0_i64
infoss.each do |infos|
  infos.sort_by! { |(type, v)| v * 2_i64 + (type == :close ? 1_i64 : 0_i64) }
  depth = 0_i64
  open = 0_i64
  infos.each do |(type, v)|
    if type == :open
      depth += 1
      if depth == 1
        open = v
      end
    else
      depth -= 1
    end
    if depth == 0
      close = v
      ret += (close - open) // (2 * d) + 1
    end
  end
end
p ret
