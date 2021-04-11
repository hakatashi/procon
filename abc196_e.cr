def max(a, b)
  a > b ? a : b
end
def min(a, b)
  a < b ? a : b
end

alias Func = Tuple(Int64, Int64)

INF = 1_000_000_000_000_000_000_i64

n = read_line.to_i64
fs = [] of Func
n.times do
  a, t = read_line.split.map(&.to_i64)
  fs << {a, t}
end
q = read_line.to_i64
xs = read_line.split.map(&.to_i64)

clamp_min = -INF
clamp_max = INF
offset = 0_i64
fs.each do |(a, t)|
  if t == 1
    clamp_min += a
    clamp_max += a
    offset += a
  elsif t == 2
    clamp_min = max(a, clamp_min)
    clamp_max = max(a, clamp_max)
  else
    clamp_min = min(a, clamp_min)
    clamp_max = min(a, clamp_max)
  end
end

xs.each do |x|
  p min(clamp_max, max(clamp_min, x + offset))
end
