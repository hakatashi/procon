def factors(n)
  ret = Array(UInt64).new
  Math.sqrt(n).to_i.times do |i|
    if n % (i + 1) == 0
      ret << (i + 1).to_u64
      ret << (n // (i + 1)).to_u64
    end
  end
  ret.uniq
end
gets
ais = STDIN.gets_to_end.split.map(&.to_u64)
balls = Array(UInt64).new(ais.size + 1, 0_u64)
counts = Array(UInt64).new(ais.size + 1, 0_u64)
ais.reverse.each_with_index do |a, ri|
  i = ais.size - ri
  if (counts[i] % 2) ^ a == 1
    balls[i] = 1_u64
    factors(i).each do |factor|
      counts[factor] += 1
    end
  end
end
ret = Array(Int32).new
balls.each_with_index do |ball, i|
  if ball == 1
    ret << i
  end
end
puts ret.size
puts ret.join(" ")
