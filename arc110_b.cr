N = 10_000_000_000_i64

gets
t = read_line.chars

if t.size == 1
  if t.join == "1"
    p N * 2
  else
    p N
  end
  exit
end

if t.size == 2
  if t.join == "00"
    p 0
  elsif t.join == "01"
    p N - 1
  elsif t.join == "10"
    p N
  else
    p N
  end
  exit
end

slices = t.each_slice(3).to_a
if slices.first.join != "110" && slices.first.join != "101" && slices.first.join != "011"
  p 0
  exit
end

ok = slices.each.with_index.all? do |(slice, i)|
  slices.first.join.starts_with?(slice.join)
end
unless ok
  p 0
  exit
end

p N - slices.size + 1
