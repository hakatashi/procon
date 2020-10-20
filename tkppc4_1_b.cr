n, k = read_line.split.map(&.to_u64)
ais = read_line.split.map(&.to_u64)
answer = -1_i64
ais.each_with_index do |a, i|
  if a < k
    if answer == -1
      answer = i
    elsif a > ais[answer]
      answer = i
    end
  end
end
if answer == -1
  puts -1
else
  puts answer + 1
end
