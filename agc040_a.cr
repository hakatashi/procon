s = read_line
up = 0_i64
down = 0_i64
if s[0] == '>'
  down = 1_i64
else
  up = 1_i64
end
ret = 0_i64
s.chars.each_cons(2) do |(pc, c)|
  if pc == '>' && c == '<'
    if up == down
      ret += up * up
    else
      max = [up, down].max
      min = [up, down].min
      ret += max * (max + 1) // 2
      ret += min * (min - 1) // 2
    end
    up = 0_i64
    down = 0_i64
  end
  if c == '>'
    down += 1_i64
  else
    up += 1_i64
  end
end
if up == down
  ret += up * up
else
  max = [up, down].max
  min = [up, down].min
  ret += max * (max + 1) // 2
  ret += min * (min - 1) // 2
end
p ret