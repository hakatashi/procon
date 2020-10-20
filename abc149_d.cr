n, k = read_line.split.map(&.to_i64)
r, s, pe = read_line.split.map(&.to_i64)
ts = read_line.chars
pts = {r, s, pe}

def getpt(pts, c)
  r, s, pe = pts
  if c == 'r'
    pe
  elsif c == 's'
    r
  else
    s
  end
end

ans = 0_i64
k.times do |i|
  ptr = i
  prev = nil.as(Nil | Int32)
  until ptr >= ts.size
    c = ts[ptr]
    if prev.nil?
      ans += getpt(pts, c)
      prev = c
    elsif prev == c
      prev = nil
    else
      ans += getpt(pts, c)
      prev = c
    end
    ptr += k
  end
end
p ans
