n, k = read_line.split.map(&.to_i)
s = read_line
chunks = s.chars.chunk(&.itself).to_a
if chunks.first[0] == '0'
  chunks.unshift({'1', [] of Char})
end
if chunks.last[0] == '0'
  chunks << {'1', [] of Char}
end
tokens = [] of Int32
sum = 0
ret = 0
chunks.each do |c, a|
  size = a.size
  tokens << size
  sum += size
  if tokens.size > k * 2 + 1
    pop = tokens.shift
    sum -= pop
  end
  if c == '1'
    ret = [ret, sum].max
  end
end
p ret