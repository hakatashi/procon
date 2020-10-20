n = read_line.to_i
9.times do |i|
  9.times do |j|
    if (i + 1) * (j + 1) == n
      puts "Yes"
      exit
    end
  end
end
puts "No"
