n = read_line.to_i64
cs = read_line.chars
r_count = cs.count('R')
ans = 0_i64
ri = cs.rindex('R')
if ri.nil?
  unordered = 0
else
  unordered = ri - r_count + 1
end

if unordered == 0
  p 0
  exit
end
min = 999_999_999_999_999_999_i64
cs.each do |c|
  if c == 'W'
    ans += 1
    unordered -= 1
  end
  if r_count > 0
    r_count -= 1
  end
  if min > ans + r_count
    min = ans + r_count
  end
end
p min
