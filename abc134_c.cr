gets
ais = STDIN.gets_to_end.split.map(&.to_u64)
max, second = ais.sort.reverse
if max == second
  ais.size.times do
    puts max
  end
else
  ais.each do |a|
    if a == max
      puts second
    else
      puts max
    end
  end
end
