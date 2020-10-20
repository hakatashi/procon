n, k, q = read_line.split.map(&.to_u64)
ais = STDIN.gets_to_end.lines.map(&.to_u64)
counter = Hash(UInt64, UInt64).new(0_u64)
ais.each { |a| counter[a] += 1 }
n.times do |i|
  count = counter[i + 1] || 0_u64
  if q - count <= k - 1
    puts "Yes"
  else
    puts "No"
  end
end
