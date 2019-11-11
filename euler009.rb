t = gets.to_i
t.times do
  n = gets.to_i
  ret = -1
  1.upto(n - 1) do |a|
    if (n * n - 2 * n * a) % (2 * (n - a)) == 0
      b = (n * n - 2 * n * a) / (2 * (n - a))
      c = n - a - b
      if b > 0
        ret = [ret, a * b * c].max
      end
    end
  end
  p ret
end