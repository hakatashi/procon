s = read_line
t = read_line
dists = Array(Array(Int64)).new(26) { Array(Int64).new(s.size, -1_i64) }
rs = s.reverse * 2
rs.chars.each_with_index do |rc, ri|
  i = (s.size * 2 - ri - 1) % s.size
  c = rc - 'a'
  dists.each_with_index do |d, ci|
    if ci == c
      d[i] = 0_i64
    elsif d[(i + s.size + 1) % s.size] != -1_i64
      d[i] = d[(i + s.size + 1) % s.size] + 1
    end
  end
end
ptr = 0_u64
ret = 0_u64
t.chars.each do |c|
  dist = dists[c - 'a'][ptr]
  if dist == -1_i64
    puts "-1"
    exit
  end
  ret += dist + 1
  ptr = (ptr + dist + 1) % s.size
end
puts ret
