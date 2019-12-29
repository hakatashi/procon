n = read_line.to_i
h = Hash(String, Int32).new(0)
n.times do
  h[read_line] += 1
end
puts h.max_by {|k, v| v}.first