s = read_line
k = read_line.to_u64

chunks = s.chars.to_a.chunk(&.itself).map {|(c, s)| s.as(Array(Char))} .to_a
if chunks.size == 1
  puts s.size.to_u64 * k / 2
  exit
end
if k == 1_u64
  puts chunks.map {|chunk| chunk.size.to_u64 / 2} .sum
  exit
end
flag = false
tmp = 0_u64
if chunks.first[0] == chunks.last[0]
  tmp = chunks.first.size.to_u64 / 2 + chunks.last.size.to_u64 / 2
  flag = true
  chunks[0] += chunks.last
  chunks.pop
end
ret = chunks.map {|chunk| chunk.size.to_u64 / 2} .sum
if flag == false
  puts ret * k
else
  puts ret * k - chunks.first.size.to_u64 / 2 + tmp
end