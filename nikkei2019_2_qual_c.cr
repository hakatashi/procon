gets
ais = read_line.split.map(&.to_i)
bs = read_line.split.map(&.to_i)
sorted_as = ais.sort
sorted_bs = bs.sort
impossible = sorted_as.zip(sorted_bs).any? {|(a, b)| a > b}
if impossible
  puts "No"
  exit
end
spare = sorted_as.each_with_index.any? do |a, i|
  if i == 0
    false
  else
    a <= sorted_bs[i - 1]
  end
end
if spare
  puts "Yes"
  exit
end
hash = Hash(Int32, Int32).new
sorted_hash = Hash(Int32, Int32).new
unique = true
bs.zip(ais).each do |(b, a)|
  if hash.has_key? b
    unique = false
  end
  hash[b] = a
end
sorted_as.each_with_index do |a, i|
  sorted_hash[a] = i
end
unless unique
  puts "Yes"
end
cycle_length = 0
start = ais[0]
prev_node = start
node = nil
while node != start
  node = prev_node
  index = sorted_hash[node]
  translated = sorted_bs[index]
  prev_node = hash[translated]
  node = prev_node
  cycle_length += 1
end
if cycle_length == ais.size
  puts "No"
else
  puts "Yes"
end
