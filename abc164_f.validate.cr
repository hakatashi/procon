# input
f = File.open(ARGV[0])
n = f.read_line.to_u64
ss = f.read_line.split.map(&.to_u64)
ts = f.read_line.split.map(&.to_u64)
us = f.read_line.split.map(&.to_u64)
vs = f.read_line.split.map(&.to_u64)
f.close

# output
f = File.open(ARGV[1])
ais = Array(UInt64).new(n * n)
n.times do
  row = f.read_line.split.map(&.to_u64)
  row.each do |a|
    ais << a
  end
end
f.close

ss.zip(us).each_with_index do |(s, u), y|
  if s == 0
    result = (0...n).map { |x| ais[y * n + x] }.reduce { |a, b| a & b }
  else
    result = (0...n).map { |x| ais[y * n + x] }.reduce { |a, b| a | b }
  end
  unless result == u
    puts "WA"
    exit
  end
end

ts.zip(vs).each_with_index do |(t, v), x|
  if t == 0
    result = (0...n).map { |y| ais[y * n + x] }.reduce { |a, b| a & b }
  end
  if t == 1
    result = (0...n).map { |y| ais[y * n + x] }.reduce { |a, b| a | b }
  end
  unless result == v
    puts "WA"
    exit
  end
end

puts "AC"
