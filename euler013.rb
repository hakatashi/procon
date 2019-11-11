t = gets.to_i
sum = 0
t.times do
  sum += gets.to_i
end
puts sum.to_s[0...10]