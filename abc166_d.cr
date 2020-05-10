x = read_line.to_i64
(-1000_i64..1000_i64).each do |a|
  (-1000_i64..1000_i64).each do |b|
    if a ** 5 - b ** 5 == x
      puts "#{a} #{b}"
      exit
    end
  end
end