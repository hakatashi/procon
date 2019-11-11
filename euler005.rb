t = gets.to_i
t.times do
  n = gets.to_i
  ret = 1
  1.upto(n) do |i|
    ret *= i / ret.gcd(i)
  end
  p ret
end