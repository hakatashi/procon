n = read_line.to_i64
h = Hash(String, Int64).new(0_i64)
n.times do
  c = read_line
  h[c] += 1
end
puts "AC x #{h["AC"]}"
puts "WA x #{h["WA"]}"
puts "TLE x #{h["TLE"]}"
puts "RE x #{h["RE"]}"
