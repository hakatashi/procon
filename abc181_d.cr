s = read_line
if s.size == 1
  puts s == "8" ? "Yes" : "No"
  exit
end
if s.size == 2
  puts (s.to_i64 % 8 == 0 || s.reverse.to_i64 % 8 == 0) ? "Yes" : "No"
  exit
end
counter = Hash(Char, Int64).new(0_i64)
s.chars.each do |c|
  counter[c] += 1
end
0_i64.step(by: 8, to: 999) do |i|
  counter2 = Hash(Char, Int64).new(0_i64)
  (i + 1000).to_s[1..].chars.each do |c|
    counter2[c] += 1
  end
  ok = counter2.all? do |k, v|
    counter[k] >= v
  end
  if ok
    puts "Yes"
    exit
  end
end
puts "No"
