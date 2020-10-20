a1 = read_line.split.map(&.to_i64)
a2 = read_line.split.map(&.to_i64)
a3 = read_line.split.map(&.to_i64)
aiss = [a1, a2, a3]
n = read_line.to_i64
bs = [] of Int64
n.times do
  b = read_line.to_i64
  aiss.each do |ais|
    ais.each_with_index do |a, i|
      if a == b
        ais[i] = 0_i64
      end
    end
  end
end
3.times do |i|
  if aiss[i][0] == 0 && aiss[i][1] == 0 && aiss[i][2] == 0
    puts "Yes"
    exit
  end
  if aiss[0][i] == 0 && aiss[1][i] == 0 && aiss[2][i] == 0
    puts "Yes"
    exit
  end
end
if aiss[0][0] == 0 && aiss[1][1] == 0 && aiss[2][2] == 0
  puts "Yes"
elsif aiss[2][0] == 0 && aiss[1][1] == 0 && aiss[0][2] == 0
  puts "Yes"
else
  puts "No"
end
