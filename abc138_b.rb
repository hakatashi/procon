gets
ret = gets.split.map(&:to_f).map {|a| 1.0 / a} .sum
puts 1.0 / ret