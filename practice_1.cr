gets
a = read_line.chars.map(&.to_i).each_with_object(Array.new(4, 0)) { |c, a| a[c - 1] += 1 }
puts "#{a.max} #{a.min}"
