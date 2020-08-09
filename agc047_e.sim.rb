reg = [0] * 200000
reg[0] = 1000
reg[1] = 334
File.read('agc047_e.txt').lines.each do |line|
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