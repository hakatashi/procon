n, x = read_line.split.map(&.to_i64)
s = read_line
s.chars.each do |c|
  if c == 'o'
    x += 1
  else
    if x != 0
      x -= 1
    end
  end
end
p x