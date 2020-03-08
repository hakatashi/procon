s = read_line
q = read_line.to_i64
prefix = Array(Char).new(200_000)
suffix = Array(Char).new(200_000)
reversed = false
q.times do
  args = read_line.split
  if args[0] == "1"
    reversed = !reversed
  else
    f = args[1].to_i64
    c = args[2][0]
    if (f == 1 && !reversed) || (f == 2 && reversed)
      prefix << c
    else
      suffix << c
    end
  end
end
if reversed
  puts suffix.reverse.join + s.reverse + prefix.join
else
  puts prefix.reverse.join + s + suffix.join
end