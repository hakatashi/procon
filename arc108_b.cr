n = read_line.to_i64
s = read_line
ans = 0_i64
stack = Deque(Char).new
s.chars.each do |c|
  if c == 'x'
    if stack.size >= 2 && stack[-1] == 'o' && stack[-2] == 'f'
      stack.pop
      stack.pop
      ans += 1
      next
    end
  end
  stack << c
end
p n - ans * 3