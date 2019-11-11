pals = []
100.upto(999) do |i|
  100.upto(999) do |j|
    n = (i * j).to_s
    if n.size == 6 && n.reverse == n
      pals << i * j
    end
  end
end
pals = pals.uniq.sort.reverse
t = gets.to_i
t.times do
  n = gets.to_i
  p pals.bsearch {|v| v < n}
end