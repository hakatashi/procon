def get_product(zeros, product)
  if zeros.zero?
    product
  else
    0
  end
end

t = gets.to_i
t.times do
  n, k = gets.split.map(&:to_i)
  s = gets.chars.map(&:to_i)
  product = s[0...k].map {|v| v.zero? ? 1 : v}.inject(:*)
  zeros = s[0...k].count {|v| v == 0}
  ret = get_product(zeros, product)
  (n - k).times do |i|
    if s[k + i].zero?
      zeros += 1
    end
    if s[i].zero?
      zeros -= 1
    end
    product = product * (s[k + i].zero? ? 1 : s[k + i]) / (s[i].zero? ? 1 : s[i])
    ret = [ret, get_product(zeros, product)].max
  end
  p ret
end