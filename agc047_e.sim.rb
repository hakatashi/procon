reg = [0] * 200000
reg[0] = 1000000000
reg[1] = 1000000000
File.read('agc047_e.txt').lines.each_with_index do |line, i|
  next if i == 0
  op, a, b, c = line.chop.split
  a = a.to_i
  b = b.to_i
  c = c.to_i
  if op == '+'
    reg[c] = reg[a] + reg[b]
  elsif op == '<'
    reg[c] = reg[a] < reg[b] ? 1 : 0
  else
    raise
  end
end
p reg[2]