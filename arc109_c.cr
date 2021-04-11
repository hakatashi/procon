n, k = read_line.split.map(&.to_i64)
s = read_line

TABLE = {
  'R' => {'R' => 'R', 'P' => 'P', 'S' => 'R'},
  'P' => {'R' => 'P', 'P' => 'P', 'S' => 'S'},
  'S' => {'R' => 'R', 'P' => 'S', 'S' => 'S'},
}

def battle(a, b)
  TABLE[a].not_nil![b].not_nil!
end

k.times do
  new_s = ""
  n.times do |i|
    new_s += battle(s[(i * 2) % n], s[(i * 2 + 1) % n])
  end
  s = new_s
end

puts s[0]
