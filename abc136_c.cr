gets
hs = read_line.split.map(&.to_u64).reverse
n = hs[0]
hs.each do |h|
  if n < h - 1
    puts "No"
    exit
  else
    if n == h - 1
      n = h - 1
    else
      n = h
    end
  end
end
puts "Yes"
