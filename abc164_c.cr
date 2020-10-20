n = read_line.to_i64
s = Set(String).new
n.times do
  s << read_line
end
p s.size
