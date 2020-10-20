gets
ais = read_line.split(" ").map(&.to_u64)
counts = Hash(UInt64, UInt64).new(0_u64)
ais.each do |a|
  if ais.size % 3 != 0 && a != 0
    puts "No"
    exit
  end
  counts[a] += 1
end
if ais.size % 3 != 0
  puts "Yes"
  exit
end
vs = Array(UInt64).new
counts.each do |c|
  n, count = c
  if count % (ais.size // 3) != 0
    puts "No"
    exit
  end
  (count // (ais.size // 3)).times do
    vs << n
  end
end
if vs.reduce { |a, b| a ^ b } == 0
  puts "Yes"
else
  puts "No"
end
