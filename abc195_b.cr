a, b, w = read_line.split.map(&.to_i64)

min = 1_000_000_000_i64
max = 0_i64
cnt = 0_i64
1_i64.upto(1_000_000_i64) do |i|
  if a * i <= w * 1000 && w * 1000 <= b * i
    if i < min
      min = i
    end
    if i > max
      max = i
    end
    cnt += 1
  end
end
if cnt == 0
  puts "UNSATISFIABLE"
else
  puts "#{min} #{max}"
end

