s = read_line
is_reversed = false
t = Deque(Char).new
s.chars.each do |c|
  if c == 'R'
    is_reversed = !is_reversed
  else
    if is_reversed
      t.unshift(c)
    else
      t << c
    end
  end
end
stack = Deque(Char).new
if is_reversed
  t.reverse_each do |c|
    if !stack.empty? && c == stack.last
      stack.pop
    else
      stack << c
    end
  end
else
  t.each do |c|
    if !stack.empty? && c == stack.last
      stack.pop
    else
      stack << c
    end
  end
end
puts stack.join